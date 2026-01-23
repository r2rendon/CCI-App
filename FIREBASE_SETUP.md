# Configuración de Firebase Cloud Messaging (FCM)

Este documento explica cómo configurar Firebase Cloud Messaging para recibir notificaciones push cuando hay transmisiones en vivo.

## Paso 1: Crear proyecto en Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Haz clic en "Agregar proyecto" o selecciona un proyecto existente
3. Sigue los pasos para crear/configurar el proyecto

## Paso 2: Agregar Android al proyecto

1. En Firebase Console, haz clic en el ícono de Android
2. Ingresa el **Package name**: `com.example.cci_app` (o el que uses en tu `build.gradle`)
3. Descarga el archivo `google-services.json`
4. Coloca el archivo en: `android/app/google-services.json`

## Paso 3: Configurar Android

1. Abre `android/build.gradle` y agrega:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

2. Abre `android/app/build.gradle` y agrega al final:
```gradle
apply plugin: 'com.google.gms.google-services'
```

## Paso 4: Agregar iOS al proyecto (opcional)

1. En Firebase Console, haz clic en el ícono de iOS
2. Ingresa el **Bundle ID**: `com.example.cciApp` (o el que uses)
3. Descarga el archivo `GoogleService-Info.plist`
4. Coloca el archivo en: `ios/Runner/GoogleService-Info.plist`

## Paso 5: Obtener Server Key de FCM

1. En Firebase Console, ve a **Configuración del proyecto** (ícono de engranaje)
2. Ve a la pestaña **Cloud Messaging**
3. Copia la **Clave del servidor** (Server Key)

## Paso 6: Configurar AWS Lambda

1. Ve a tu función Lambda `cci-send-fcm-notification`
2. Agrega estas variables de entorno:
   - `FCM_SERVER_KEY`: La clave del servidor que copiaste
   - `FCM_TOPIC`: `cci_live_streams` (o el tema que prefieras)
   - `DYNAMODB_TABLE_NAME`: `cci-live-status`
   - `YOUTUBE_API_KEY`: Tu clave de YouTube API
   - `CHANNEL_ID`: Tu ID de canal de YouTube

## Paso 7: Crear tabla DynamoDB

1. Ve a DynamoDB en AWS Console
2. Crea una nueva tabla:
   - **Nombre**: `cci-live-status`
   - **Clave de partición**: `status` (String)
   - Configuración por defecto está bien

## Paso 8: Configurar EventBridge (Cron)

1. Ve a EventBridge en AWS Console
2. Crea una regla:
   - **Nombre**: `cci-live-check-rule`
   - **Tipo**: Programación
   - **Expresión de cron**: `*/5 * * * ? *` (cada 5 minutos)
   - **Objetivo**: Lambda function `cci-send-fcm-notification`

## Paso 9: Instalar dependencias

Ejecuta en la terminal:
```bash
flutter pub get
```

## Paso 10: Probar

1. Ejecuta la app
2. Acepta los permisos de notificaciones
3. Cuando haya una transmisión en vivo, recibirás una notificación push automáticamente

## Notas importantes

- Las notificaciones push funcionan incluso cuando la app está cerrada
- El Lambda se ejecuta cada 5 minutos para verificar transmisiones nuevas
- Solo se envía una notificación por transmisión nueva (no se repite)
- Si la app está en primer plano, mostrará una notificación local además de la push

