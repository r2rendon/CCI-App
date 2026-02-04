"""
Una sola Lambda para todas las pantallas de eventos.
- Eventos general: category = "general" (o se omite).
- Next:  category = "next"
- Alive: category = "alive"
- Shift: category = "shift"

Al crear (POST) se envía "category" en el body.
Al listar (GET) se usa ?category=general|next|alive|shift.
"""
import json
import re
import urllib.request
import urllib.parse
import os
import boto3
from datetime import datetime
from decimal import Decimal

def _format_am_pm(dt):
    """Formato legible con AM/PM para DynamoDB: DD/MM/YYYY H:MM AM/PM"""
    hour = dt.hour
    hour12 = 12 if hour == 0 else (hour if hour <= 12 else hour - 12)
    minute = dt.minute
    period = 'AM' if hour < 12 else 'PM'
    return f'{dt.day:02d}/{dt.month:02d}/{dt.year} {hour12}:{minute:02d} {period}'

def _parse_event_date(date_str):
    """Parsea eventDate (ISO o DD/MM/YYYY H:MM AM/PM) a datetime."""
    if not date_str:
        return None
    s = str(date_str).strip()
    # Intentar ISO primero
    try:
        return datetime.fromisoformat(s.replace('Z', '+00:00'))
    except Exception:
        pass
    # Intentar DD/MM/YYYY H:MM AM/PM (ej. "06/02/2026 7:00 PM")
    m = re.match(r'(\d{1,2})/(\d{1,2})/(\d{4})\s+(\d{1,2}):(\d{2})\s*(AM|PM)?', s, re.I)
    if m:
        d, mo, y = int(m.group(1)), int(m.group(2)), int(m.group(3))
        h, mi = int(m.group(4)), int(m.group(5))
        period = (m.group(6) or '').upper()
        if period == 'PM' and h != 12:
            h += 12
        elif period == 'AM' and h == 12:
            h = 0
        return datetime(y, mo, d, h, mi)
    return None

def _normalize_event_date_display(date_str):
    """Asegura formato DD/MM/YYYY H:MM AM/PM con ceros a la izquierda."""
    parsed = _parse_event_date(date_str)
    if parsed:
        return _format_am_pm(parsed)
    return date_str

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
    """Obtener eventos activos. Opcional: ?category=general|next|alive|shift"""
    try:
        params = event.get('queryStringParameters') or {}
        category = (params.get('category') or '').strip().lower() or None

        response = table.scan()
        events = response.get('Items', [])

        # Filtrar solo eventos futuros o actuales
        now = datetime.utcnow().isoformat()
        active_events = [
            ev for ev in events
            if ev.get('eventDate', '') >= now
        ]

        # Filtrar por categoría si se especifica
        if category:
            active_events = [
                ev for ev in active_events
                if (ev.get('category') or 'general').lower() == category
            ]
        else:
            # Eventos general: solo los que no tienen categoría o tienen "general"
            active_events = [
                ev for ev in active_events
                if (ev.get('category') or 'general').lower() == 'general'
            ]

        # Ordenar por fecha
        active_events.sort(key=lambda x: x.get('eventDate', ''))
        
        # Normalizar para JSON: Decimal -> str y eventID -> eventId para la app
        for ev in active_events:
            if 'eventDate' in ev:
                ev['eventDate'] = str(ev['eventDate'])
            if 'createdAt' in ev:
                ev['createdAt'] = str(ev['createdAt'])
            if 'eventID' in ev and 'eventId' not in ev:
                ev['eventId'] = ev['eventID']
        
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
        
        # category: general (default), next, alive, shift
        category = (body.get('category') or 'general').strip().lower()

        now_utc = datetime.utcnow()
        created_at_display = _format_am_pm(now_utc)
        event_date_raw = body['eventDate']
        parsed = _parse_event_date(event_date_raw)
        # eventDate en ISO para filtro; eventDateDisplay en formato legible "06/02/2026 7:00 PM"
        event_date_iso = parsed.isoformat() + 'Z' if parsed else event_date_raw
        event_date_display = _normalize_event_date_display(event_date_raw)

        new_event = {
            'eventID': event_id,
            'name': body['name'],
            'eventDate': event_date_iso,
            'imageUrl': body['imageUrl'],
            'description': body.get('description', ''),
            'registrationLink': body.get('registrationLink', ''),
            'location': body.get('location', 'San Pedro Sula'),
            'category': category,
            'createdAt': created_at_display,
            'notified': False,
            'eventDateDisplay': event_date_display,
        }
        
        # Guardar en DynamoDB
        table.put_item(Item=new_event)
        
        # Respuesta API con eventId (camelCase) para la app
        event_for_response = {**new_event, 'eventId': event_id}
        return {
            'statusCode': 201,
            'headers': headers,
            'body': json.dumps({
                'message': 'Evento creado exitosamente',
                'eventId': event_id,
                'event': event_for_response
            })
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': headers,
            'body': json.dumps({'error': f'Error creando evento: {str(e)}'})
        }

