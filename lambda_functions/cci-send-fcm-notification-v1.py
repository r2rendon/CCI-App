import json
import urllib.request
import urllib.parse
import os
import boto3
from datetime import datetime
from google.oauth2 import service_account
import google.auth.transport.requests

# Inicializar DynamoDB
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('DYNAMODB_TABLE_NAME', 'cci-live-status')
table = dynamodb.Table(table_name)

def get_access_token(service_account_info):
    """Obtiene un token de acceso OAuth2 usando las credenciales de la cuenta de servicio"""
    credentials = service_account.Credentials.from_service_account_info(
        service_account_info,
        scopes=['https://www.googleapis.com/auth/firebase.messaging']
    )
    credentials.refresh(google.auth.transport.requests.Request())
    return credentials.token

def send_fcm_notification_v1(project_id, access_token, topic, title, body, data):
    """Envía una notificación usando la API V1 de Firebase"""
    url = f'https://fcm.googleapis.com/v1/projects/{project_id}/messages:send'
    
    message = {
        'message': {
            'topic': topic,
            'notification': {
                'title': title,
                'body': body
            },
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
                'headers': {
                    'apns-priority': '10'
                },
                'payload': {
                    'aps': {
                        'sound': 'default',
                        'alert': {
                            'title': title,
                            'body': body
                        }
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
    
    response = urllib.request.urlopen(req)
    return json.loads(response.read())

def lambda_handler(event, context):
    # Obtener credenciales de variables de entorno
    API_KEY = os.environ.get('YOUTUBE_API_KEY', 'AIzaSyDO0CcbkSLIPECMG7CkZYhhgy8vHov5nTM')
    CHANNEL_ID = os.environ.get('CHANNEL_ID', 'UC_taLU-KdaO8pivmzhUfRmw')
    FCM_PROJECT_ID = os.environ.get('FCM_PROJECT_ID', '')
    FCM_SERVICE_ACCOUNT_JSON = os.environ.get('FCM_SERVICE_ACCOUNT_JSON', '')
    FCM_TOPIC = os.environ.get('FCM_TOPIC', 'cci_live_streams')
    
    if not FCM_PROJECT_ID or not FCM_SERVICE_ACCOUNT_JSON:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'FCM_PROJECT_ID y FCM_SERVICE_ACCOUNT_JSON deben estar configurados'})
        }
    
    # Obtener transmisión en vivo
    live_url = f'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId={CHANNEL_ID}&eventType=live&type=video&key={API_KEY}'
    
    current_live_video_id = None
    try:
        live_response = urllib.request.urlopen(live_url)
        live_data = json.loads(live_response.read())
        if live_data.get('items') and len(live_data['items']) > 0:
            current_live_video_id = live_data['items'][0]['id']['videoId']
    except Exception as e:
        print(f"Error obteniendo transmisión en vivo: {str(e)}")
        current_live_video_id = None
    
    # Obtener el último estado guardado
    try:
        response = table.get_item(Key={'status': 'live'})
        last_live_video_id = response.get('Item', {}).get('videoId', None)
        notified = response.get('Item', {}).get('notified', False)
    except Exception as e:
        print(f"Error leyendo DynamoDB: {str(e)}")
        last_live_video_id = None
        notified = False
    
    # Si hay una transmisión nueva (diferente a la anterior) y no se ha notificado
    if current_live_video_id and current_live_video_id != last_live_video_id and not notified:
        # Enviar notificación FCM usando API V1
        try:
            # Parsear el JSON de la cuenta de servicio
            service_account_info = json.loads(FCM_SERVICE_ACCOUNT_JSON)
            
            # Obtener token de acceso
            access_token = get_access_token(service_account_info)
            
            # Enviar notificación
            result = send_fcm_notification_v1(
                project_id=FCM_PROJECT_ID,
                access_token=access_token,
                topic=FCM_TOPIC,
                title='🔴 Transmisión en Vivo',
                body='¡Hay una transmisión en vivo disponible ahora!',
                data={
                    'type': 'live_stream',
                    'videoId': current_live_video_id,
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                }
            )
            print(f"Notificación FCM enviada: {result}")
        except Exception as e:
            print(f"Error enviando notificación FCM: {str(e)}")
        
        # Guardar el nuevo estado
        try:
            table.put_item(
                Item={
                    'status': 'live',
                    'videoId': current_live_video_id,
                    'timestamp': datetime.utcnow().isoformat(),
                    'notified': True
                }
            )
            print(f"Nueva transmisión detectada y notificada: {current_live_video_id}")
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'newLiveStream': True,
                    'videoId': current_live_video_id,
                    'notificationSent': True
                })
            }
        except Exception as e:
            print(f"Error guardando en DynamoDB: {str(e)}")
    
    # Si no hay transmisión en vivo y había una antes, limpiar el estado
    if not current_live_video_id and last_live_video_id:
        try:
            table.put_item(
                Item={
                    'status': 'live',
                    'videoId': '',
                    'timestamp': datetime.utcnow().isoformat(),
                    'notified': False
                }
            )
        except Exception as e:
            print(f"Error actualizando DynamoDB: {str(e)}")
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'newLiveStream': False,
            'videoId': current_live_video_id or ''
        })
    }

