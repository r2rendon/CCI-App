# Configuración de AWS para "Amazon 1" (Eventos)

Esta guía te ayudará a configurar AWS para gestionar eventos/anuncios con notificaciones push.

## Paso 1: Crear tabla DynamoDB para eventos

1. Ve a **DynamoDB** en AWS Console
2. Haz clic en **"Crear tabla"**
3. Configura:
   - **Nombre de la tabla**: `cci-events`
   - **Clave de partición**: `eventId` (Tipo: String)
   - **Configuración por defecto**: Deja todo lo demás por defecto
4. Haz clic en **"Crear tabla"**

## Paso 2: Crear función Lambda para API de eventos

1. Ve a **Lambda** en AWS Console
2. Haz clic en **"Crear función"**
3. Configura:
   - **Nombre**: `cci-events-api`
   - **Runtime**: Python 3.11 o superior
   - **Arquitectura**: x86_64
4. Haz clic en **"Crear función"**

### Agregar código a Lambda

1. En la función Lambda, ve a la pestaña **"Código"**
2. Abre el archivo `lambda_function.py`
3. Reemplaza todo el contenido con el código de: `lambda_functions/cci-events-api.py`
4. Haz clic en **"Desplegar"**

### Configurar variables de entorno

1. En la función Lambda, ve a **"Configuración"** → **"Variables de entorno"**
2. Haz clic en **"Editar"**
3. Agrega esta variable:
   - `DYNAMODB_TABLE_NAME`: `cci-events`
4. Haz clic en **"Guardar"**

### Agregar permisos a Lambda

1. En la función Lambda, ve a **"Configuración"** → **"Permisos"**
2. Haz clic en el rol de ejecución
3. En **"Agregar permisos"** → **"Adjuntar políticas"**
4. Busca y adjunta:
   - `AmazonDynamoDBFullAccess` (o crea una política más restrictiva)
5. Haz clic en **"Agregar permisos"**

## Paso 3: Crear API Gateway para eventos

1. Ve a **API Gateway** en AWS Console
2. Haz clic en **"Crear API"**
3. Selecciona **"HTTP API"** → **"Construir"**
4. En **"Integraciones"**:
   - Haz clic en **"Agregar integración"**
   - Tipo: Lambda
   - Región: us-east-2 (o la que uses)
   - Función Lambda: `cci-events-api`
   - Versión: $LATEST
5. En **"Configurar rutas"**:
   - Método: GET
   - Ruta: `/events`
   - Integración: la que acabas de crear
6. Agrega otra ruta:
   - Método: POST
   - Ruta: `/events`
   - Integración: la misma
7. Haz clic en **"Revisar y crear"**
8. Nombre de la API: `cci-events-api`
9. Haz clic en **"Crear"**

### Obtener URL del endpoint

1. Ve a **"Etapas"** en el menú lateral
2. Selecciona la etapa (probablemente `$default`)
3. Copia la **"URL de invocación"**
4. Actualiza `aws_config.dart` con esta URL:
   ```dart
   static const String eventsEndpoint = 'https://TU_API_ID.execute-api.us-east-2.amazonaws.com';
   ```

### Agregar permisos de Lambda

1. Ve a la función Lambda `cci-events-api`
2. Ve a **"Configuración"** → **"Permisos"**
3. Haz clic en **"Agregar permiso"**
4. Configura:
   - Tipo: Servicio de AWS
   - Servicio: API Gateway
   - Entidad principal: `apigateway.amazonaws.com`
   - ARN de origen: `arn:aws:execute-api:us-east-2:TU_ACCOUNT_ID:TU_API_ID/*`
   - Acción: `lambda:InvokeFunction`
5. Haz clic en **"Guardar"**

## Paso 4: Crear función Lambda para notificaciones de eventos

1. Ve a **Lambda** en AWS Console
2. Haz clic en **"Crear función"**
3. Configura:
   - **Nombre**: `cci-events-notification-checker`
   - **Runtime**: Python 3.11 o superior
   - **Arquitectura**: x86_64
4. Haz clic en **"Crear función"**

### Agregar código a Lambda

1. En la función Lambda, ve a la pestaña **"Código"**
2. Abre el archivo `lambda_function.py`
3. Reemplaza todo el contenido con el código de: `lambda_functions/cci-events-notification-checker.py`
4. Haz clic en **"Desplegar"**

### Configurar variables de entorno

1. En la función Lambda, ve a **"Configuración"** → **"Variables de entorno"**
2. Haz clic en **"Editar"**
3. Agrega estas variables:
   - `DYNAMODB_TABLE_NAME`: `cci-events`
   - `FCM_SERVER_KEY`: (La misma que usaste para transmisiones)
   - `FCM_EVENTS_TOPIC`: `cci_events`
4. Haz clic en **"Guardar"**

### Agregar permisos a Lambda

1. En la función Lambda, ve a **"Configuración"** → **"Permisos"**
2. Haz clic en el rol de ejecución
3. En **"Agregar permisos"** → **"Adjuntar políticas"**
4. Busca y adjunta:
   - `AmazonDynamoDBFullAccess` (o crea una política más restrictiva)
5. Haz clic en **"Agregar permisos"**

## Paso 5: Configurar EventBridge para notificaciones

1. Ve a **EventBridge** en AWS Console
2. En el menú lateral, haz clic en **"Reglas"**
3. Haz clic en **"Crear regla"**
4. Configura:
   - **Nombre**: `cci-events-notification-rule`
   - **Tipo de regla**: **Regla programada**
   - **Patrón de evento**: **Expresión de cron**
   - **Expresión de cron**: `*/10 * * * ? *` (cada 10 minutos)
5. En **"Seleccionar objetivos"**:
   - **Tipo de destino**: Lambda function
   - **Función**: `cci-events-notification-checker`
6. Haz clic en **"Siguiente"** y luego **"Crear regla"**

## Paso 6: Subir imágenes de eventos a S3

Para que las imágenes de eventos funcionen, necesitas subirlas a S3:

1. Ve a **S3** en AWS Console
2. Crea un bucket (o usa uno existente): `cci-events-images`
3. Configura permisos públicos de lectura para las imágenes
4. Cuando crees un evento, usa la URL de S3 como `imageUrl`

Ejemplo de URL: `https://cci-events-images.s3.us-east-2.amazonaws.com/evento1.jpg`

## Paso 7: Crear eventos desde AWS

Puedes crear eventos de dos formas:

### Opción 1: Desde la consola de DynamoDB
1. Ve a DynamoDB → Tabla `cci-events`
2. Haz clic en **"Explorar elementos de tabla"**
3. Haz clic en **"Crear elemento"**
4. Agrega los campos:
   - `eventId`: `event_1234567890` (único)
   - `name`: `Nombre del evento`
   - `eventDate`: `2024-12-25T19:00:00` (formato ISO)
   - `imageUrl`: `https://...` (URL de S3)
   - `description`: `Descripción del evento`
   - `registrationLink`: `https://...` (opcional)
   - `location`: `San Pedro Sula`
   - `createdAt`: `2024-01-21T10:00:00`
   - `notified`: `false`

### Opción 2: Desde API Gateway (POST)
Usa Postman o curl para hacer POST a:
```
POST https://TU_API_ID.execute-api.us-east-2.amazonaws.com/events
Content-Type: application/json

{
  "name": "Nombre del evento",
  "eventDate": "2024-12-25T19:00:00",
  "imageUrl": "https://cci-events-images.s3.us-east-2.amazonaws.com/evento1.jpg",
  "description": "Descripción del evento",
  "registrationLink": "https://forms.google.com/...",
  "location": "San Pedro Sula"
}
```

## Paso 8: Probar

1. Crea un evento nuevo (método POST o desde DynamoDB)
2. Espera 10 minutos para que EventBridge ejecute el Lambda
3. O ejecuta manualmente el Lambda `cci-events-notification-checker`
4. Deberías recibir una notificación push en todos los dispositivos

## Notas importantes

- El Lambda de notificaciones se ejecuta cada 10 minutos
- Solo envía notificación para eventos con `notified: false`
- Una vez notificado, marca el evento como `notified: true`
- Las imágenes deben estar en S3 con permisos públicos
- El formato de fecha debe ser ISO: `YYYY-MM-DDTHH:MM:SS`

