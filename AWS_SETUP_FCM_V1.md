# Configuración de Firebase Cloud Messaging V1 en AWS Lambda

Esta guía te ayudará a configurar los Lambdas de AWS para usar la API V1 de Firebase Cloud Messaging.

## Paso 1: Actualizar el Lambda de Eventos

1. Ve a **Lambda** en AWS Console
2. Busca y abre la función: `cci-events-notification-checker`
3. Ve a la pestaña **"Código"**
4. Reemplaza todo el contenido con el código de: `lambda_functions/cci-events-notification-checker-v1.py`
5. Haz clic en **"Desplegar"**

### Instalar dependencias necesarias

Los Lambdas necesitan la librería `google-auth` para autenticarse con Firebase. Necesitas crear un "Layer" de Lambda:

1. En Lambda, ve a **"Capas"** en el menú lateral
2. Haz clic en **"Crear capa"**
3. Configura:
   - **Nombre**: `google-auth-layer`
   - **Descripción**: `Google Auth library for Firebase FCM V1`
4. Necesitas crear un archivo ZIP con la librería:
   - Crea una carpeta: `python/lib/python3.11/site-packages/`
   - Instala `google-auth` y `google-auth-oauthlib` en esa carpeta
   - Comprime todo en un ZIP
   - Sube el ZIP a la capa
5. Haz clic en **"Crear"**

### Agregar la capa al Lambda

1. Ve de vuelta a `cci-events-notification-checker`
2. Ve a **"Capas"** (en la sección de configuración)
3. Haz clic en **"Agregar capa"**
4. Selecciona **"Capas personalizadas"**
5. Selecciona `google-auth-layer`
6. Haz clic en **"Agregar"**

### Configurar variables de entorno

1. En `cci-events-notification-checker`, ve a **"Configuración"** → **"Variables de entorno"**
2. Haz clic en **"Editar"**
3. Agrega/actualiza estas variables:
   - `FCM_PROJECT_ID`: `cci-app-5bac1`
   - `FCM_SERVICE_ACCOUNT_JSON`: (Pega aquí el contenido COMPLETO del archivo JSON que descargaste, como un string JSON)
   - `FCM_EVENTS_TOPIC`: `cci_events`
   - `DYNAMODB_TABLE_NAME`: `cci-events`
4. Haz clic en **"Guardar"**

**IMPORTANTE**: Para `FCM_SERVICE_ACCOUNT_JSON`, necesitas pegar el JSON completo como un string. Por ejemplo:
```
{"type":"service_account","project_id":"cci-app-5bac1","private_key_id":"...","private_key":"...","client_email":"...","client_id":"...","auth_uri":"...","token_uri":"...","auth_provider_x509_cert_url":"...","client_x509_cert_url":"...","universe_domain":"googleapis.com"}
```

## Paso 2: Actualizar el Lambda de Transmisiones en Vivo

1. Ve a **Lambda** en AWS Console
2. Busca y abre la función: `cci-send-fcm-notification` (o el nombre que le hayas dado)
3. Ve a la pestaña **"Código"**
4. Reemplaza todo el contenido con el código de: `lambda_functions/cci-send-fcm-notification-v1.py`
5. Haz clic en **"Desplegar"**

### Agregar la capa al Lambda

1. Ve a **"Capas"** en la configuración del Lambda
2. Haz clic en **"Agregar capa"**
3. Selecciona `google-auth-layer`
4. Haz clic en **"Agregar"**

### Configurar variables de entorno

1. Ve a **"Configuración"** → **"Variables de entorno"**
2. Haz clic en **"Editar"**
3. Agrega/actualiza estas variables:
   - `FCM_PROJECT_ID`: `cci-app-5bac1`
   - `FCM_SERVICE_ACCOUNT_JSON`: (El mismo JSON completo que usaste arriba)
   - `FCM_TOPIC`: `cci_live_streams`
   - `YOUTUBE_API_KEY`: `AIzaSyDO0CcbkSLIPECMG7CkZYhhgy8vHov5nTM`
   - `CHANNEL_ID`: `UC_taLU-KdaO8pivmzhUfRmw`
   - `DYNAMODB_TABLE_NAME`: `cci-live-status`
4. Haz clic en **"Guardar"**

## Paso 3: Crear el Layer de Google Auth (Alternativa más fácil)

Si prefieres, puedes usar un layer público existente o crear uno manualmente:

### Opción A: Usar un layer público (más fácil)

Busca en AWS Lambda Layers públicos que contengan `google-auth` para Python 3.11.

### Opción B: Crear el layer manualmente

1. En tu máquina local, crea una carpeta temporal
2. Ejecuta:
   ```bash
   mkdir -p python/lib/python3.11/site-packages
   pip install google-auth google-auth-oauthlib -t python/lib/python3.11/site-packages/
   zip -r google-auth-layer.zip python/
   ```
3. Sube `google-auth-layer.zip` como una nueva capa en Lambda

## Paso 4: Probar

1. Ejecuta manualmente uno de los Lambdas desde la consola de AWS
2. Verifica los logs para ver si las notificaciones se envían correctamente
3. Deberías recibir una notificación push en tu dispositivo Android

## Notas importantes

- El `FCM_SERVICE_ACCOUNT_JSON` debe ser el JSON completo como un string (sin saltos de línea)
- Asegúrate de que el runtime de Python en Lambda sea 3.11 o superior
- Las notificaciones ahora usan la API V1 de Firebase, que es más moderna y segura

