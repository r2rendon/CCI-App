# Guía para Activar Notificaciones Push en iOS

## Estado Actual

✅ **Notificaciones Locales**: Funcionan completamente en iOS  
⏳ **Notificaciones Push de Firebase**: Listas para activar cuando actualices Xcode

## Requisitos para Activar Push en iOS

1. **Xcode 15.1 o superior** (soporta Swift 6.0)
2. **APNs configurado en Firebase** (requiere cuenta de Apple Developer)

## Pasos para Activar (Cuando Tengas Xcode Actualizado)

### Paso 1: Actualizar Xcode

1. Abre **App Store**
2. Busca "Xcode"
3. Haz clic en **"Actualizar"** (si hay una actualización disponible)
4. Espera a que se complete la descarga e instalación

### Paso 2: Verificar Versión de Xcode

```bash
xcodebuild -version
```

Debe mostrar **Xcode 15.1 o superior**.

### Paso 3: Limpiar y Reinstalar Dependencias

```bash
cd /Users/imac/Documents/CCI-App/CCI-App
flutter clean
flutter pub get
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

### Paso 4: Configurar APNs en Firebase (Si No Está Configurado)

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto: **cci-app-5bac1**
3. Ve a **Configuración del proyecto** (⚙️) > **Cloud Messaging**
4. En la sección **Apple app configuration**:
   - Si ya está configurado: ✅ Listo
   - Si no está configurado:
     - Necesitas una **APNs Authentication Key** desde Apple Developer Portal
     - O un **APNs Certificate**
     - Sigue las instrucciones en `PRUEBA_NOTIFICACIONES_IOS.md`

### Paso 5: Compilar y Ejecutar

```bash
flutter run --release
```

O desde Xcode:
1. Abre `ios/Runner.xcworkspace`
2. Selecciona tu dispositivo iOS
3. Presiona **Run** (▶️)

### Paso 6: Verificar que Funciona

1. La app debe solicitar permisos de notificaciones
2. En la consola deberías ver:
   ```
   FCM Token: [token largo]
   FCM inicializado correctamente en iOS
   ```
3. Prueba enviando una notificación desde Firebase Console

## Código Ya Configurado

✅ **AppDelegate.swift**: Configurado para Firebase y APNs  
✅ **fcm_service.dart**: Handler de segundo plano completo  
✅ **main.dart**: Inicialización de Firebase para iOS  
✅ **Podfile**: Configurado con características experimentales de Swift  

## Notas Importantes

- **Las notificaciones locales ya funcionan** en iOS sin necesidad de actualizar Xcode
- **Las push de Firebase** solo funcionarán después de actualizar Xcode
- **APNs es necesario** para recibir notificaciones push en iOS (requiere cuenta de Apple Developer)

## Si Tienes Problemas

1. Verifica que Xcode esté actualizado: `xcodebuild -version`
2. Verifica que APNs esté configurado en Firebase Console
3. Verifica permisos de notificaciones en el iPhone: Configuración > CCI San Pedro Sula > Notificaciones
4. Revisa los logs en la consola de Flutter para ver errores específicos

