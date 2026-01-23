# Crear Layer de Google Auth para Lambda

## Opción 1: Crear el Layer manualmente (Recomendado)

### Paso 1: Crear la estructura de carpetas

En tu terminal, ejecuta estos comandos:

```bash
# Crear directorio temporal
mkdir -p /tmp/google-auth-layer/python/lib/python3.11/site-packages
cd /tmp/google-auth-layer

# Instalar las librerías necesarias
pip3 install google-auth google-auth-oauthlib requests -t python/lib/python3.11/site-packages/

# Crear el ZIP
zip -r google-auth-layer.zip python/

# El archivo google-auth-layer.zip está listo para subir a Lambda
```

### Paso 2: Subir el Layer a Lambda

1. Ve a **Lambda** en AWS Console
2. En el menú lateral, haz clic en **"Capas"** (Layers)
3. Haz clic en **"Crear capa"** (Create layer)
4. Configura:
   - **Nombre**: `google-auth-layer`
   - **Descripción**: `Google Auth library for Firebase FCM V1`
   - **Cargar un archivo .zip**: Sube el archivo `google-auth-layer.zip` que creaste
   - **Arquitecturas compatibles**: `x86_64`
   - **Versiones de tiempo de ejecución**: `Python 3.11` (o la versión que uses)
5. Haz clic en **"Crear"**

## Opción 2: Usar un Layer público existente

Puedes buscar layers públicos que contengan `google-auth` en:
- https://github.com/mthenw/awesome-layers
- O buscar en la consola de Lambda en "Capas" → "Capas públicas"

## Opción 3: Usar el código actualizado sin Layer (Temporal)

Si prefieres no crear el layer ahora, puedes usar los Lambdas actualizados que tienen un mensaje indicando que se necesita el layer. Las notificaciones no funcionarán hasta que configures el layer, pero el código estará listo.

