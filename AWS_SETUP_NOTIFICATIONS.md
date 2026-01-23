# Configuración de AWS para Notificaciones Push

Esta guía te ayudará a configurar AWS para enviar notificaciones push cuando hay transmisiones en vivo.

## Paso 1: Crear tabla DynamoDB

1. Ve a **DynamoDB** en AWS Console
2. Haz clic en **"Crear tabla"**
3. Configura:
   - **Nombre de la tabla**: `cci-live-status`
   - **Clave de partición**: `status` (Tipo: String)
   - **Configuración por defecto**: Deja todo lo demás por defecto
4. Haz clic en **"Crear tabla"**

## Paso 2: Crear función Lambda para notificaciones

1. Ve a **Lambda** en AWS Console
2. Haz clic en **"Crear función"**
3. Configura:
   - **Nombre**: `cci-send-fcm-notification`
   - **Runtime**: Python 3.11 o superior
   - **Arquitectura**: x86_64
4. Haz clic en **"Crear función"**

## Paso 3: Agregar código a Lambda

1. En la función Lambda, ve a la pestaña **"Código"**
2. Abre el archivo `lambda_function.py`
3. Reemplaza todo el contenido con el código de: `lambda_functions/cci-send-fcm-notification.py`
4. Haz clic en **"Desplegar"**

## Paso 4: Configurar variables de entorno

1. En la función Lambda, ve a **"Configuración"** → **"Variables de entorno"**
2. Haz clic en **"Editar"**
3. Agrega estas variables:
   - `YOUTUBE_API_KEY`: `AIzaSyDO0CcbkSLIPECMG7CkZYhhgy8vHov5nTM`
   - `CHANNEL_ID`: `UC_taLU-KdaO8pivmzhUfRmw`
   - `FCM_SERVER_KEY`: (La obtendrás de Firebase - ver FIREBASE_SETUP.md)
   - `FCM_TOPIC`: `cci_live_streams`
   - `DYNAMODB_TABLE_NAME`: `cci-live-status`
4. Haz clic en **"Guardar"**

## Paso 5: Agregar permisos a Lambda

1. En la función Lambda, ve a **"Configuración"** → **"Permisos"**
2. Haz clic en el rol de ejecución
3. En **"Agregar permisos"** → **"Adjuntar políticas"**
4. Busca y adjunta:
   - `AmazonDynamoDBFullAccess` (o crea una política más restrictiva)
5. Haz clic en **"Agregar permisos"**

## Paso 6: Configurar EventBridge (Cron)

1. Ve a **EventBridge** en AWS Console
2. En el menú lateral, haz clic en **"Reglas"**
3. Haz clic en **"Crear regla"**
4. Configura:
   - **Nombre**: `cci-live-check-rule`
   - **Tipo de regla**: **Regla programada**
   - **Patrón de evento**: **Expresión de cron**
   - **Expresión de cron**: `*/5 * * * ? *` (cada 5 minutos)
5. En **"Seleccionar objetivos"**:
   - **Tipo de destino**: Lambda function
   - **Función**: `cci-send-fcm-notification`
6. Haz clic en **"Siguiente"** y luego **"Crear regla"**

## Paso 7: Obtener FCM Server Key

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto
3. Ve a **Configuración del proyecto** (ícono de engranaje)
4. Ve a la pestaña **"Cloud Messaging"**
5. Copia la **"Clave del servidor"** (Server Key)
6. Vuelve a Lambda y agrega esta clave como variable de entorno `FCM_SERVER_KEY`

## Paso 8: Probar

1. Espera 5 minutos para que EventBridge ejecute el Lambda
2. O ejecuta manualmente el Lambda desde la consola
3. Si hay una transmisión en vivo, deberías recibir una notificación push

## Notas importantes

- El Lambda se ejecuta cada 5 minutos automáticamente
- Solo envía una notificación por transmisión nueva (no se repite)
- Si no hay transmisión en vivo, no se envía nada
- Las notificaciones se envían a todos los dispositivos suscritos al tema `cci_live_streams`

