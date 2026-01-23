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
table_name = os.environ.get('DYNAMODB_TABLE_NAME', 'cci-events')
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
                'priority': 'high'
            },
            'apns': {
                'headers': {
                    'apns-priority': '10'
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
    # Obtener variables de entorno
    FCM_PROJECT_ID = os.environ.get('FCM_PROJECT_ID', '')
    FCM_SERVICE_ACCOUNT_JSON = os.environ.get('FCM_SERVICE_ACCOUNT_JSON', '')
    FCM_TOPIC = os.environ.get('FCM_EVENTS_TOPIC', 'cci_events')
    
    if not FCM_PROJECT_ID or not FCM_SERVICE_ACCOUNT_JSON:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'FCM_PROJECT_ID y FCM_SERVICE_ACCOUNT_JSON deben estar configurados'})
        }
    
    try:
        # Parsear el JSON de la cuenta de servicio
        service_account_info = json.loads(FCM_SERVICE_ACCOUNT_JSON)
        
        # Obtener token de acceso
        access_token = get_access_token(service_account_info)
        
        # Obtener todos los eventos no notificados
        response = table.scan(
            FilterExpression='notified = :notified',
            ExpressionAttributeValues={':notified': False}
        )
        
        new_events = response.get('Items', [])
        
        if not new_events:
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'message': 'No hay eventos nuevos',
                    'notificationsSent': 0
                })
            }
        
        notifications_sent = 0
        
        for event in new_events:
            # Enviar notificación FCM usando API V1
            try:
                result = send_fcm_notification_v1(
                    project_id=FCM_PROJECT_ID,
                    access_token=access_token,
                    topic=FCM_TOPIC,
                    title='📅 Nuevo Evento',
                    body=f"{event.get('name', 'Nuevo evento')} - {_format_date(event.get('eventDate', ''))}",
                    data={
                        'type': 'new_event',
                        'eventId': event.get('eventId', ''),
                        'eventName': event.get('name', ''),
                        'eventDate': event.get('eventDate', ''),
                        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                    }
                )
                print(f"Notificación FCM enviada para evento {event.get('eventId')}: {result}")
                
                # Marcar como notificado
                table.update_item(
                    Key={'eventId': event.get('eventId')},
                    UpdateExpression='SET notified = :notified',
                    ExpressionAttributeValues={':notified': True}
                )
                
                notifications_sent += 1
            except Exception as e:
                print(f"Error enviando notificación FCM para evento {event.get('eventId')}: {str(e)}")
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': f'Notificaciones enviadas para {notifications_sent} evento(s)',
                'notificationsSent': notifications_sent
            })
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': f'Error procesando eventos: {str(e)}'})
        }

def _format_date(date_str):
    """Formatea la fecha para mostrar en la notificación"""
    try:
        dt = datetime.fromisoformat(date_str.replace('Z', '+00:00'))
        return dt.strftime('%d/%m/%Y %H:%M')
    except:
        return date_str
