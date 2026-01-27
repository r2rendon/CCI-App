# Guía para Probar Notificaciones Push en iOS

## Configuración Previa

### 1. Verificar Configuración de Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto: **cci-app-5bac1**
3. Ve a **Configuración del proyecto** (⚙️) > **Cloud Messaging**
4. Verifica que el **APNs Authentication Key** o **APNs Certificates** esté configurado:
   - Si no está configurado, necesitarás:
     - Un certificado APNs desde Apple Developer Portal, O
     - Una APNs Authentication Key (recomendado)

### 2. Obtener APNs Authentication Key (Recomendado)

1. Ve a [Apple Developer Portal](https://developer.apple.com/account/resources/authkeys/list)
2. Crea una nueva **Key** con el nombre "Firebase APNs Key"
3. Selecciona **Apple Push Notifications service (APNs)**
4. Descarga la clave (solo se puede descargar una vez)
5. En Firebase Console:
   - Ve a **Configuración del proyecto** > **Cloud Messaging**
   - En la sección **Apple app configuration**, sube la clave `.p8`
   - Ingresa el **Key ID** y el **Team ID** de tu cuenta de Apple Developer

## Pasos para Probar Notificaciones

### Paso 1: Ejecutar la App en un Dispositivo iOS Real

⚠️ **Importante**: Las notificaciones push NO funcionan en el simulador de iOS. Necesitas un dispositivo físico.

```bash
# Conecta tu iPhone/iPad al Mac
# Ejecuta la app en el dispositivo
flutter run --release
```

O desde Xcode:
1. Abre `ios/Runner.xcworkspace` en Xcode
2. Selecciona tu dispositivo iOS en la barra de herramientas
3. Presiona el botón **Run** (▶️)

### Paso 2: Verificar Permisos de Notificaciones

1. Al abrir la app por primera vez, iOS pedirá permiso para notificaciones
2. Acepta las notificaciones cuando aparezca el diálogo
3. Si rechazaste antes, ve a **Configuración** > **CCI San Pedro Sula** > **Notificaciones** y habilítalas

### Paso 3: Verificar Token FCM en la Consola

Cuando la app se ejecute, deberías ver en la consola de Flutter:

```
FCM Token: [un token largo]
FCM inicializado correctamente en iOS
Usuario autorizó notificaciones
```

**Copia este token** - lo necesitarás para probar.

### Paso 4: Probar Notificación desde Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto: **cci-app-5bac1**
3. Ve a **Engage** > **Cloud Messaging**
4. Haz clic en **"Enviar tu primer mensaje"** o **"Nuevo mensaje"**
5. Completa el formulario:
   - **Título**: "Prueba de Notificación"
   - **Texto**: "Esta es una notificación de prueba desde Firebase"
6. Haz clic en **"Siguiente"**
7. En **Destinatarios**:
   - Selecciona **"Tema"**
   - Ingresa: `cci_live_streams` o `cci_events`
   - O selecciona **"Token FCM"** y pega el token que copiaste
8. Haz clic en **"Siguiente"** y luego **"Revisar"**
9. Haz clic en **"Publicar"**

### Paso 5: Verificar Recepción de Notificación

**Si la app está en primer plano:**
- Deberías ver una notificación local en la app
- Revisa la consola de Flutter para ver los logs

**Si la app está en segundo plano:**
- Deberías recibir la notificación en el centro de notificaciones de iOS
- Al tocar la notificación, la app debería abrirse

**Si la app está cerrada:**
- Deberías recibir la notificación en el centro de notificaciones
- Al tocar la notificación, la app debería abrirse

### Paso 6: Probar Notificación con Datos Personalizados

Para probar la navegación a pantallas específicas:

1. En Firebase Console, al crear el mensaje:
   - Haz clic en **"Agregar campo personalizado"**
   - **Clave**: `type`
   - **Valor**: `live_stream` o `new_event`
2. Envía la notificación
3. Al tocar la notificación, la app debería navegar a:
   - **Transmisiones** (si `type: live_stream`)
   - **Eventos** (si `type: new_event`)

## Probar Notificaciones desde AWS Lambda

Las notificaciones también se enviarán automáticamente cuando:

1. **Haya una transmisión en vivo** (cada 10 minutos se verifica)
2. **Se agregue un nuevo evento** (cada 30 minutos se verifica)

Para probar manualmente desde AWS:

1. Ve a [AWS Lambda Console](https://console.aws.amazon.com/lambda/)
2. Selecciona la función: `cci-send-fcm-notification-v1` o `cci-events-notification-checker-v1`
3. Haz clic en **"Test"**
4. Crea un evento de prueba (puede estar vacío)
5. Ejecuta la función

## Solución de Problemas

### La app no solicita permisos de notificaciones

- Verifica que `Info.plist` tenga la configuración correcta
- Reinstala la app completamente
- Verifica que el dispositivo tenga conexión a internet

### No recibo notificaciones

1. **Verifica el token FCM**:
   - Asegúrate de que el token se imprima en la consola
   - Verifica que el token no sea `null`

2. **Verifica la configuración de APNs en Firebase**:
   - Ve a Firebase Console > Configuración > Cloud Messaging
   - Verifica que APNs esté configurado correctamente

3. **Verifica que el dispositivo tenga conexión a internet**

4. **Verifica los permisos**:
   - Ve a Configuración > CCI San Pedro Sula > Notificaciones
   - Asegúrate de que estén habilitadas

5. **Revisa los logs de la consola**:
   - Busca errores relacionados con Firebase o FCM

### La notificación no navega a la pantalla correcta

- Verifica que el campo `type` esté en los datos de la notificación
- Revisa los logs de la consola para ver qué tipo de notificación se recibió
- Verifica que `MainNavigation.navigateToPage()` esté funcionando correctamente

### Error: "No valid 'aps-environment' entitlement"

- Esto significa que el certificado de desarrollo no está configurado correctamente
- Necesitas un perfil de aprovisionamiento válido con notificaciones push habilitadas
- Ve a [Apple Developer Portal](https://developer.apple.com/account/resources/profiles/list) y crea/actualiza tu perfil de aprovisionamiento

## Verificación Final

✅ La app solicita permisos de notificaciones al iniciar
✅ El token FCM se imprime en la consola
✅ Las notificaciones se reciben cuando la app está en segundo plano
✅ Las notificaciones navegan a la pantalla correcta al tocarlas
✅ Las notificaciones automáticas desde AWS funcionan

## Notas Importantes

- ⚠️ Las notificaciones push **NO funcionan en el simulador de iOS**
- ⚠️ Necesitas un **dispositivo físico** para probar
- ⚠️ Necesitas un **perfil de aprovisionamiento válido** con notificaciones push habilitadas
- ⚠️ El **APNs debe estar configurado** en Firebase Console
- ⚠️ Las notificaciones pueden tardar unos segundos en llegar

