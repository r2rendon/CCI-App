import json
import urllib.request
import urllib.parse
import os

def lambda_handler(event, context):
    # Obtener credenciales de variables de entorno (más seguro)
    API_KEY = os.environ.get('YOUTUBE_API_KEY', 'AIzaSyDO0CcbkSLIPECMG7CkZYhhgy8vHov5nTM')
    CHANNEL_ID = os.environ.get('CHANNEL_ID', 'UC_taLU-KdaO8pivmzhUfRmw')
    
    # Obtener transmisión en vivo
    live_url = f'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId={CHANNEL_ID}&eventType=live&type=video&key={API_KEY}'
    
    live_video_id = None
    try:
        live_response = urllib.request.urlopen(live_url)
        live_data = json.loads(live_response.read())
        if live_data.get('items') and len(live_data['items']) > 0:
            live_video_id = live_data['items'][0]['id']['videoId']
    except Exception as e:
        print(f"Error obteniendo transmisión en vivo: {str(e)}")
        live_video_id = None
    
    # Obtener último video (transmisión reciente)
    recent_url = f'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId={CHANNEL_ID}&type=video&order=date&maxResults=1&key={API_KEY}'
    
    recent_video_id = None
    try:
        recent_response = urllib.request.urlopen(recent_url)
        recent_data = json.loads(recent_response.read())
        if recent_data.get('items') and len(recent_data['items']) > 0:
            recent_video_id = recent_data['items'][0]['id']['videoId']
    except Exception as e:
        print(f"Error obteniendo video reciente: {str(e)}")
        recent_video_id = None
    
    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        },
        'body': json.dumps({
            'liveVideoId': live_video_id or '',
            'recentVideoId': recent_video_id or ''
        })
    }

