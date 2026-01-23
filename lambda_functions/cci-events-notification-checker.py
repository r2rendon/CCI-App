import json
import urllib.request
import urllib.parse
import os
import boto3
from datetime import datetime

# Inicializar DynamoDB
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('DYNAMODB_TABLE_NAME', 'cci-events')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    # Obtener variables de entorno
    FCM_SERVER_KEY = os.environ.get('FCM_SERVER_KEY', '')
    FCM_TOPIC = os.environ.get('FCM_EVENTS_TOPIC', 'cci_events')
    
    try:
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
            # Enviar notificación FCM
            if FCM_SERVER_KEY:
                try:
                    fcm_url = 'https://fcm.googleapis.com/fcm/send'
                    fcm_data = {
                        'to': f'/topics/{FCM_TOPIC}',
                        'notification': {
                            'title': '📅 Nuevo Evento',
                            'body': f"{event.get('name', 'Nuevo evento')} - {_format_date(event.get('eventDate', ''))}",
                            'sound': 'default',
                        },
                        'data': {
                            'type': 'new_event',
                            'eventId': event.get('eventId', ''),
                            'eventName': event.get('name', ''),
                            'eventDate': event.get('eventDate', ''),
                            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                        },
                        'priority': 'high',
                    }
                    
                    req = urllib.request.Request(
                        fcm_url,
                        data=json.dumps(fcm_data).encode('utf-8'),
                        headers={
                            'Content-Type': 'application/json',
                            'Authorization': f'key={FCM_SERVER_KEY}',
                        },
                        method='POST'
                    )
                    
                    fcm_response = urllib.request.urlopen(req)
                    fcm_result = json.loads(fcm_response.read())
                    print(f"Notificación FCM enviada para evento {event.get('eventId')}: {fcm_result}")
                    
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

