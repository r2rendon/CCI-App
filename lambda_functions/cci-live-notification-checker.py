import json
import urllib.request
import urllib.parse
import os
import boto3
from datetime import datetime

# Inicializar DynamoDB
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('DYNAMODB_TABLE_NAME', 'cci-live-status')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    # Obtener credenciales de variables de entorno
    API_KEY = os.environ.get('YOUTUBE_API_KEY', 'AIzaSyDO0CcbkSLIPECMG7CkZYhhgy8vHov5nTM')
    CHANNEL_ID = os.environ.get('CHANNEL_ID', 'UC_taLU-KdaO8pivmzhUfRmw')
    
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
    except Exception as e:
        print(f"Error leyendo DynamoDB: {str(e)}")
        last_live_video_id = None
    
    # Si hay una transmisión nueva (diferente a la anterior)
    if current_live_video_id and current_live_video_id != last_live_video_id:
        # Guardar el nuevo estado
        try:
            table.put_item(
                Item={
                    'status': 'live',
                    'videoId': current_live_video_id,
                    'timestamp': datetime.utcnow().isoformat(),
                    'notified': False
                }
            )
            print(f"Nueva transmisión detectada: {current_live_video_id}")
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'newLiveStream': True,
                    'videoId': current_live_video_id
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
                    'notified': True
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

