import json
import urllib.request
import urllib.parse
import os
import boto3
from datetime import datetime
from decimal import Decimal

# Inicializar DynamoDB
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('DYNAMODB_TABLE_NAME', 'cci-events')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    http_method = event.get('httpMethod', event.get('requestContext', {}).get('http', {}).get('method', 'GET'))
    
    # Manejar CORS
    headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,POST,OPTIONS',
        'Content-Type': 'application/json'
    }
    
    # Manejar preflight OPTIONS
    if http_method == 'OPTIONS':
        return {
            'statusCode': 200,
            'headers': headers,
            'body': ''
        }
    
    try:
        if http_method == 'GET':
            return handle_get(event, headers)
        elif http_method == 'POST':
            return handle_post(event, headers)
        else:
            return {
                'statusCode': 405,
                'headers': headers,
                'body': json.dumps({'error': 'Method not allowed'})
            }
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': headers,
            'body': json.dumps({'error': str(e)})
        }

def handle_get(event, headers):
    """Obtener todos los eventos activos"""
    try:
        # Obtener todos los eventos
        response = table.scan()
        events = response.get('Items', [])
        
        # Filtrar solo eventos futuros o actuales
        now = datetime.utcnow().isoformat()
        active_events = [
            event for event in events 
            if event.get('eventDate', '') >= now
        ]
        
        # Ordenar por fecha
        active_events.sort(key=lambda x: x.get('eventDate', ''))
        
        # Convertir Decimal a string/int para JSON
        for event in active_events:
            if 'eventDate' in event:
                event['eventDate'] = str(event['eventDate'])
            if 'createdAt' in event:
                event['createdAt'] = str(event['createdAt'])
        
        return {
            'statusCode': 200,
            'headers': headers,
            'body': json.dumps({
                'events': active_events,
                'count': len(active_events)
            })
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': headers,
            'body': json.dumps({'error': f'Error obteniendo eventos: {str(e)}'})
        }

def handle_post(event, headers):
    """Crear un nuevo evento"""
    try:
        # Parsear el body
        body = json.loads(event.get('body', '{}'))
        
        # Validar campos requeridos
        required_fields = ['name', 'eventDate', 'imageUrl']
        for field in required_fields:
            if field not in body:
                return {
                    'statusCode': 400,
                    'headers': headers,
                    'body': json.dumps({'error': f'Campo requerido faltante: {field}'})
                }
        
        # Generar ID único
        event_id = f"event_{datetime.utcnow().timestamp()}"
        
        # Crear el evento
        new_event = {
            'eventId': event_id,
            'name': body['name'],
            'eventDate': body['eventDate'],
            'imageUrl': body['imageUrl'],
            'description': body.get('description', ''),
            'registrationLink': body.get('registrationLink', ''),
            'location': body.get('location', 'San Pedro Sula'),
            'createdAt': datetime.utcnow().isoformat(),
            'notified': False  # Para tracking de notificaciones
        }
        
        # Guardar en DynamoDB
        table.put_item(Item=new_event)
        
        return {
            'statusCode': 201,
            'headers': headers,
            'body': json.dumps({
                'message': 'Evento creado exitosamente',
                'eventId': event_id,
                'event': new_event
            })
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': headers,
            'body': json.dumps({'error': f'Error creando evento: {str(e)}'})
        }

