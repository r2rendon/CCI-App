"""
Lambda cci-live-videos - Dos modos de ejecución:

1. INVOCACIÓN DESDE API (cuando la app abre Transmisiones):
   - Lee desde DynamoDB el último estado guardado
   - NO llama a YouTube (ahorra cuota y costos)
   - Retorna liveVideoId

2. INVOCACIÓN MANUAL "Test" (cuando tú verificas que hay transmisión):
   - Llama a YouTube para verificar transmisión en vivo
   - Guarda resultado en DynamoDB
   - Si hay transmisión: envía notificación push FCM "Estamos en vivo"
   - Retorna el resultado

La app sigue llamando al API para obtener el videoId. Los datos se actualizan
solo cuando tú ejecutas "Test" en la consola de AWS Lambda.
"""
import json
import urllib.request
import os
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('DYNAMODB_TABLE_NAME', 'cci-live-status')
table = dynamodb.Table(table_name)


def _is_api_invocation(event):
    """True si la Lambda fue invocada por API Gateway (desde la app)"""
    return 'requestContext' in event


def _get_from_youtube(api_key, channel_id):
    """Consulta YouTube API. Retorna live_video_id (videos recientes descartado)."""
    live_video_id = None

    live_url = f'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId={channel_id}&eventType=live&type=video&key={api_key}'
    try:
        live_response = urllib.request.urlopen(live_url)
        live_data = json.loads(live_response.read())
        if live_data.get('items') and len(live_data['items']) > 0:
            live_video_id = live_data['items'][0]['id']['videoId']
    except Exception as e:
        print(f"Error obteniendo transmisión en vivo: {str(e)}")

    return live_video_id or ''


def _read_from_dynamodb():
    """Lee liveVideoId guardado en DynamoDB"""
    try:
        response = table.get_item(Key={'status': 'live'})
        item = response.get('Item', {})
        return item.get('videoId', '')
    except Exception as e:
        print(f"Error leyendo DynamoDB: {str(e)}")
        return ''


def _write_to_dynamodb(live_video_id):
    """Guarda en DynamoDB"""
    try:
        table.put_item(
            Item={
                'status': 'live',
                'videoId': live_video_id,
                'timestamp': datetime.utcnow().isoformat(),
                'notified': True
            }
        )
        print(f"Guardado en DynamoDB: liveVideoId={live_video_id}")
    except Exception as e:
        print(f"Error guardando en DynamoDB: {str(e)}")


def _get_fcm_token(service_account_json):
    """Obtiene token OAuth2 para FCM (requiere Lambda Layer con google-auth)"""
    from google.oauth2 import service_account
    import google.auth.transport.requests
    credentials = service_account.Credentials.from_service_account_info(
        json.loads(service_account_json),
        scopes=['https://www.googleapis.com/auth/firebase.messaging']
    )
    credentials.refresh(google.auth.transport.requests.Request())
    return credentials.token


def _send_fcm_notification(project_id, access_token, topic, title, body, data):
    """Envía notificación push FCM"""
    url = f'https://fcm.googleapis.com/v1/projects/{project_id}/messages:send'
    message = {
        'message': {
            'topic': topic,
            'notification': {'title': title, 'body': body},
            'data': {str(k): str(v) for k, v in data.items()},
            'android': {
                'priority': 'high',
                'notification': {
                    'channel_id': 'cci_notifications',
                    'sound': 'default',
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK'
                }
            },
            'apns': {
                'headers': {'apns-priority': '10'},
                'payload': {
                    'aps': {
                        'sound': 'default',
                        'alert': {'title': title, 'body': body}
                    }
                }
            }
        }
    }
    req = urllib.request.Request(
        url,
        data=json.dumps(message).encode('utf-8'),
        headers={
            'Content-Type': 'application/json',
            'Authorization': f'Bearer {access_token}'
        },
        method='POST'
    )
    urllib.request.urlopen(req)


def lambda_handler(event, context):
    API_KEY = os.environ.get('YOUTUBE_API_KEY', '')
    CHANNEL_ID = os.environ.get('CHANNEL_ID', 'UC_taLU-KdaO8pivmzhUfRmw')
    FCM_PROJECT_ID = os.environ.get('FCM_PROJECT_ID', '')
    FCM_SERVICE_ACCOUNT_JSON = os.environ.get('FCM_SERVICE_ACCOUNT_JSON', '')
    FCM_TOPIC = os.environ.get('FCM_TOPIC', 'cci_live_streams')

    headers = {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json'
    }

    # --- MODO API: la app pide datos (lee de DynamoDB, no llama YouTube) ---
    # Cuando no hay transmisión, live_id debe ser '' para que la app muestre
    # live_placeholder.png. Ejecuta "Test" cuando NO estés en vivo para guardar ''.
    if _is_api_invocation(event):
        live_id = _read_from_dynamodb()
        return {
            'statusCode': 200,
            'headers': headers,
            'body': json.dumps({
                'liveVideoId': live_id or ''
            })
        }

    # --- MODO TEST: invocación manual (consulta YouTube + guarda + notifica) ---
    live_video_id = _get_from_youtube(API_KEY, CHANNEL_ID)

    _write_to_dynamodb(live_video_id)

    notification_sent = False
    if live_video_id and FCM_PROJECT_ID and FCM_SERVICE_ACCOUNT_JSON:
        try:
            token = _get_fcm_token(FCM_SERVICE_ACCOUNT_JSON)
            _send_fcm_notification(
                project_id=FCM_PROJECT_ID,
                access_token=token,
                topic=FCM_TOPIC,
                title='🔴 Transmisión en Vivo',
                body='¡Estamos en vivo! Únete ahora.',
                data={
                    'type': 'live_stream',
                    'videoId': live_video_id,
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                }
            )
            notification_sent = True
            print(f"Notificación FCM enviada. Video: {live_video_id}")
        except ImportError as e:
            print(f"FCM no disponible (falta Lambda Layer con google-auth): {e}")
        except Exception as e:
            print(f"Error enviando FCM: {str(e)}")

    return {
        'statusCode': 200,
        'headers': headers,
        'body': json.dumps({
            'liveVideoId': live_video_id,
            'notificationSent': notification_sent,
            'message': 'Test completado. Datos guardados en DynamoDB.' if live_video_id else 'No hay transmisión en vivo detectada.'
        })
    }
