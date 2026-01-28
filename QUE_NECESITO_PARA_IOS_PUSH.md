# ¿Qué Necesito para que Funcionen los Push en iOS?

## 📱 Estado Actual

- ✅ **Notificaciones Locales**: Funcionan perfectamente AHORA
- ⏳ **Push de Firebase**: Código listo, necesita configuración

## 🎯 Lo que Necesitas (2 cosas)

### 1️⃣ Actualizar Xcode (Opcional pero Recomendado)

**Tu situación:**
- Tienes: Xcode 15.0.1 (Swift 5.9)
- Necesitas: Xcode 15.1+ (Swift 6.0) para versiones actuales de Firebase
- O usar versiones antiguas de Firebase compatibles con Xcode 15.0.1

**Cómo actualizar:**
1. Abre **App Store**
2. Busca "Xcode"
3. Haz clic en **"Actualizar"**
4. Espera a que termine (puede tardar 30-60 minutos)

**Verificar versión:**
```bash
xcodebuild -version
```

### 2️⃣ Configurar APNs en Firebase (OBLIGATORIO)

**Requisitos:**
- ✅ Cuenta de Apple Developer (gratuita o de pago)
- ✅ Bundle ID configurado en Apple Developer Portal

**Pasos:**

1. **Obtener APNs Authentication Key:**
   - Ve a [Apple Developer Portal](https://developer.apple.com/account/resources/authkeys/list)
   - Crea una nueva key con "Apple Push Notifications service (APNs)"
   - Descarga el archivo `.p8`
   - Anota el Key ID y Team ID

2. **Subir a Firebase:**
   - Ve a [Firebase Console](https://console.firebase.google.com/)
   - Selecciona tu proyecto: **cci-app-5bac1**
   - Ve a **Configuración del proyecto** (⚙️) > **Cloud Messaging**
   - En "Apple app configuration":
     - Haz clic en **"Upload"** o **"Add"**
     - Sube el archivo `.p8`
     - Ingresa el Key ID y Team ID
     - Guarda

3. **Verificar:**
   - Deberías ver un ✅ verde indicando que APNs está configurado

## 🚀 Después de Configurar

### Si Actualizaste Xcode:

```bash
cd /Users/imac/Documents/CCI-App/CCI-App
flutter clean
flutter pub get
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter run --release
```

### Si NO Actualizaste Xcode (Usando Versiones Antiguas):

El código ya está configurado con versiones compatibles. Solo necesitas:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter run --release
```

## ✅ Verificar que Funciona

1. **La app debe solicitar permisos de notificaciones** al abrirse
2. **En la consola deberías ver:**
   ```
   FCM Token: [token largo]
   FCM inicializado correctamente en iOS
   ```
3. **Prueba enviando una notificación:**
   - Ve a Firebase Console > Cloud Messaging
   - Crea una nueva notificación
   - Selecciona tu app iOS
   - Envía y verifica que llegue al dispositivo

## 📋 Checklist

- [ ] Xcode actualizado (o usando versiones antiguas de Firebase)
- [ ] APNs Authentication Key creada en Apple Developer
- [ ] APNs configurado en Firebase Console
- [ ] App compilada y ejecutándose en dispositivo físico
- [ ] Permisos de notificaciones otorgados
- [ ] FCM Token visible en consola
- [ ] Notificación de prueba recibida

## ⚠️ Notas Importantes

- **Las notificaciones locales ya funcionan** sin necesidad de configurar nada
- **Las push de Firebase** requieren APNs configurado
- **APNs solo funciona en dispositivos físicos**, no en simulador
- **Necesitas cuenta de Apple Developer** (gratuita o de pago)

## 🆘 Si Tienes Problemas

1. **Error de compilación:**
   - Verifica versión de Xcode: `xcodebuild -version`
   - Limpia y reinstala: `flutter clean && flutter pub get && cd ios && pod install`

2. **No recibe notificaciones:**
   - Verifica que APNs esté configurado en Firebase
   - Verifica permisos en iPhone: Configuración > CCI San Pedro Sula > Notificaciones
   - Verifica que estés usando un dispositivo físico (no simulador)
   - Revisa logs en consola para ver errores específicos

3. **Error de APNs:**
   - Verifica que el Bundle ID coincida en Apple Developer y Firebase
   - Verifica que la key APNs tenga permisos correctos
   - Verifica que el Team ID sea correcto

## 📞 Archivos de Referencia

- `ACTIVAR_IOS_PUSH_NOTIFICATIONS.md` - Guía detallada paso a paso
- `PRUEBA_NOTIFICACIONES_IOS.md` - Cómo probar notificaciones
- `RESUMEN_NOTIFICACIONES_IOS.md` - Estado actual del proyecto

