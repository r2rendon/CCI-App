# Configuración Paso a Paso: Firebase FCM V1 en AWS Lambda

## Resumen de lo que necesitas

1. **Layer ZIP**: `/tmp/google-auth-layer/google-auth-layer.zip` (ya creado)
2. **JSON de cuenta de servicio**: Contenido en `fcm_service_account_json.txt` (ya preparado)
3. **Project ID**: `cci-app-5bac1`

## Paso 1: Crear el Layer en AWS Lambda

1. Ve a **Lambda** en AWS Console
2. En el menú lateral izquierdo, haz clic en **"Capas"** (Layers)
3. Haz clic en **"Crear capa"** (Create layer)
4. Configura:
   - **Nombre**: `google-auth-layer`
   - **Descripción**: `Google Auth library for Firebase FCM V1 API`
   - **Cargar un archivo .zip**: 
     - Haz clic en **"Subir"** o **"Upload"**
     - Selecciona el archivo: `/tmp/google-auth-layer/google-auth-layer.zip`
     - (Si no puedes acceder a /tmp, copia el archivo a tu Escritorio primero)
   - **Arquitecturas compatibles**: Selecciona `x86_64`
   - **Versiones de tiempo de ejecución**: Selecciona `Python 3.11` (o la versión que uses en tus Lambdas)
5. Haz clic en **"Crear"** (Create)

**Nota**: Anota el ARN del layer que se crea (lo verás después de crearlo), lo necesitarás para agregarlo a los Lambdas.

## Paso 2: Actualizar Lambda `cci-events-notification-checker`

### 2.1: Actualizar el código

1. Ve a **Lambda** → Busca `cci-events-notification-checker`
2. Haz clic en la función para abrirla
3. Ve a la pestaña **"Código"**
4. Abre el archivo `lambda_function.py`
5. **Reemplaza TODO el contenido** con el código de: `lambda_functions/cci-events-notification-checker-v1.py`
6. Haz clic en **"Desplegar"** (Deploy)

### 2.2: Agregar el Layer

1. En la misma función Lambda, ve a la pestaña **"Capas"** (en la sección de configuración, no en el menú lateral)
2. Haz clic en **"Agregar capa"** (Add layer)
3. Selecciona **"Capas personalizadas"** (Custom layers)
4. En el menú desplegable, selecciona `google-auth-layer`
5. Selecciona la versión más reciente
6. Haz clic en **"Agregar"** (Add)

### 2.3: Configurar variables de entorno

1. Ve a **"Configuración"** → **"Variables de entorno"**
2. Haz clic en **"Editar"** (Edit)
3. Agrega/actualiza estas variables:

   **Variable 1:**
   - **Clave**: `FCM_PROJECT_ID`
   - **Valor**: `cci-app-5bac1`

   **Variable 2:**
   - **Clave**: `FCM_SERVICE_ACCOUNT_JSON`
   - **Valor**: (Abre el archivo `fcm_service_account_json.txt` y copia TODO su contenido, pégalo aquí)

   **Variable 3:**
   - **Clave**: `FCM_EVENTS_TOPIC`
   - **Valor**: `cci_events`

   **Variable 4:**
   - **Clave**: `DYNAMODB_TABLE_NAME`
   - **Valor**: `cci-events`

4. Haz clic en **"Guardar"** (Save)

## Paso 3: Actualizar Lambda `cci-send-fcm-notification` (si existe)

### 3.1: Actualizar el código

1. Ve a **Lambda** → Busca `cci-send-fcm-notification` (o el nombre que le hayas dado)
2. Si no existe, créalo:
   - Haz clic en **"Crear función"**
   - Nombre: `cci-send-fcm-notification`
   - Runtime: Python 3.11
   - Haz clic en **"Crear"**
3. Ve a la pestaña **"Código"**
4. Reemplaza el contenido con el código de: `lambda_functions/cci-send-fcm-notification-v1.py`
5. Haz clic en **"Desplegar"**

### 3.2: Agregar el Layer

1. Ve a **"Capas"** en la configuración
2. Agrega `google-auth-layer` (igual que en el paso 2.2)

### 3.3: Configurar variables de entorno

1. Ve a **"Configuración"** → **"Variables de entorno"**
2. Agrega/actualiza:

   - `FCM_PROJECT_ID`: `cci-app-5bac1`
   - `FCM_SERVICE_ACCOUNT_JSON`: (El mismo JSON completo que usaste arriba)
   - `FCM_TOPIC`: `cci_live_streams`
   - `YOUTUBE_API_KEY`: `AIzaSyDO0CcbkSLIPECMG7CkZYhhgy8vHov5nTM`
   - `CHANNEL_ID`: `UC_taLU-KdaO8pivmzhUfRmw`
   - `DYNAMODB_TABLE_NAME`: `cci-live-status`

3. Haz clic en **"Guardar"**

## Paso 4: Verificar permisos de los Lambdas

Asegúrate de que ambos Lambdas tengan permisos para:
- DynamoDB (lectura/escritura)
- Si usan otros servicios, esos permisos también

## Paso 5: Probar

1. Ejecuta manualmente el Lambda `cci-events-notification-checker` desde la consola
2. Verifica los logs para ver si hay errores
3. Si todo está bien, deberías recibir una notificación push en tu dispositivo Android

## Solución de problemas

- **Error "No module named 'google.oauth2'"**: El layer no está agregado correctamente
- **Error "Invalid JSON"**: El `FCM_SERVICE_ACCOUNT_JSON` no está bien formateado (debe ser una sola línea)
- **Error "Invalid credentials"**: Verifica que el JSON esté completo y correcto

## Notas importantes

- El `FCM_SERVICE_ACCOUNT_JSON` debe ser el JSON completo en una sola línea (sin saltos de línea)
- Asegúrate de que el runtime de Python en Lambda sea 3.11 o superior
- El layer debe estar en la misma región que tus Lambdas (us-east-2)

