# 💰 Costos Estimados para Lanzar la App

## 📊 Resumen Ejecutivo

**Costo Total Estimado (Primer Año):**
- **Mínimo**: $125 USD/año
- **Promedio**: $150-200 USD/año
- **Máximo**: $300+ USD/año (si hay mucho tráfico)

---

## 🍎 Apple App Store

### Apple Developer Program
- **Costo**: **$99 USD/año**
- **Incluye**:
  - Publicar apps en App Store
  - APNs para notificaciones push
  - TestFlight para pruebas
  - Certificados de desarrollo
  - Soporte técnico

**✅ OBLIGATORIO** para lanzar en iOS

---

## 🤖 Google Play Store

### Google Play Developer Account
- **Costo**: **$25 USD (pago único, de por vida)**
- **Incluye**:
  - Publicar apps en Play Store
  - Acceso a Google Play Console
  - Estadísticas y análisis

**✅ OBLIGATORIO** para lanzar en Android

---

## ☁️ Firebase (Google Cloud)

### Firebase - Plan Gratis (Spark)
- **Costo**: **$0 USD/mes**
- **Límites**:
  - 10,000 notificaciones push/mes
  - 1 GB de almacenamiento
  - 10 GB de transferencia/mes
  - 50,000 lecturas de base de datos/día

**✅ SUFICIENTE** para la mayoría de apps pequeñas/medianas

### Firebase - Plan de Pago (Blaze - Pay as you go)
- **Costo**: **Variable** (solo pagas lo que usas)
- **Cuándo necesitas esto**:
  - Más de 10,000 notificaciones/mes
  - Más de 1 GB de almacenamiento
  - Más de 10 GB de transferencia

**Estimación**: $0-50 USD/mes (depende del uso)

---

## ☁️ Amazon Web Services (AWS)

### Servicios Actuales en tu App:

#### 1. Lambda Functions
- **Costo**: **$0 USD** (dentro del free tier)
- **Free Tier**: 1 millón de solicitudes/mes gratis
- **Después**: $0.20 por 1 millón de solicitudes

**Estimación**: $0-5 USD/mes (para uso normal)

#### 2. API Gateway
- **Costo**: **$0 USD** (dentro del free tier)
- **Free Tier**: 1 millón de solicitudes/mes gratis
- **Después**: $3.50 por millón de solicitudes

**Estimación**: $0-10 USD/mes (para uso normal)

#### 3. DynamoDB
- **Costo**: **$0 USD** (dentro del free tier)
- **Free Tier**: 25 GB de almacenamiento, 200 millones de lecturas/mes
- **Después**: $0.25 por GB/mes + $1.25 por millón de lecturas

**Estimación**: $0-5 USD/mes (para uso normal)

#### 4. S3 (Almacenamiento de imágenes)
- **Costo**: **$0 USD** (dentro del free tier)
- **Free Tier**: 5 GB de almacenamiento, 20,000 solicitudes GET/mes
- **Después**: $0.023 por GB/mes + $0.0004 por 1,000 solicitudes

**Estimación**: $0-3 USD/mes (para uso normal)

#### 5. EventBridge (Scheduled Rules)
- **Costo**: **$0 USD** (dentro del free tier)
- **Free Tier**: 14 millones de eventos/mes gratis
- **Después**: $1.00 por millón de eventos

**Estimación**: $0 USD/mes (para uso normal)

### AWS Free Tier
- **Duración**: 12 meses desde la creación de la cuenta
- **Después**: Pagas solo por lo que usas (pay-as-you-go)

**Estimación Total AWS (Primer Año)**: **$0-25 USD/mes** = **$0-300 USD/año**

---

## 📱 YouTube Data API

### YouTube Data API v3
- **Costo**: **$0 USD**
- **Límite**: 10,000 unidades de cuota/día (gratis)
- **Tu uso**: ~100 unidades/día (muy por debajo del límite)

**✅ GRATIS** para tu caso de uso

---

## 📊 Desglose de Costos

### Costos Fijos (Obligatorios)

| Servicio | Costo | Frecuencia | Total Año 1 |
|----------|-------|------------|-------------|
| Apple Developer Program | $99 | Anual | $99 |
| Google Play Developer | $25 | Pago único | $25 |
| **TOTAL FIJO** | | | **$124** |

### Costos Variables (Opcionales/Dependen del Uso)

| Servicio | Estimación Mensual | Estimación Anual |
|----------|-------------------|------------------|
| Firebase (si excedes free tier) | $0-50 | $0-600 |
| AWS (después del free tier) | $0-25 | $0-300 |
| **TOTAL VARIABLE** | **$0-75** | **$0-900** |

---

## 💵 Escenarios de Costo

### Escenario 1: Mínimo (Recomendado para empezar)
- Apple Developer: $99/año
- Google Play: $25 (pago único)
- Firebase: $0 (free tier suficiente)
- AWS: $0 (free tier suficiente)
- **Total Año 1**: **$124 USD**
- **Total Año 2+**: **$99 USD/año** (solo Apple)

### Escenario 2: Promedio (App con uso moderado)
- Apple Developer: $99/año
- Google Play: $25 (pago único)
- Firebase: $10-20/mes = $120-240/año
- AWS: $5-10/mes = $60-120/año
- **Total Año 1**: **$304-484 USD**
- **Total Año 2+**: **$180-360 USD/año**

### Escenario 3: Alto Tráfico (App muy popular)
- Apple Developer: $99/año
- Google Play: $25 (pago único)
- Firebase: $50-100/mes = $600-1,200/año
- AWS: $20-50/mes = $240-600/año
- **Total Año 1**: **$964-1,924 USD**
- **Total Año 2+**: **$840-1,800 USD/año**

---

## 🎯 Recomendación

### Para Empezar (Año 1)
**Presupuesto recomendado**: **$150-200 USD**

Esto cubre:
- ✅ Apple Developer: $99
- ✅ Google Play: $25
- ✅ Buffer para servicios: $25-75

### Para Mantener (Año 2+)
**Presupuesto recomendado**: **$100-200 USD/año**

Esto cubre:
- ✅ Apple Developer: $99/año
- ✅ Servicios variables: $0-100/año

---

## 📈 Cuándo Necesitarás Pagar Más

### Firebase (Blaze Plan)
Necesitarás el plan de pago si:
- Más de 10,000 notificaciones push/mes
- Más de 1 GB de almacenamiento de imágenes
- Más de 10 GB de transferencia/mes

**Solución**: Empieza con el plan gratis y actualiza cuando sea necesario.

### AWS (Después del Free Tier)
Necesitarás pagar si:
- Más de 1 millón de solicitudes Lambda/mes
- Más de 1 millón de solicitudes API Gateway/mes
- Más de 25 GB en DynamoDB
- Más de 5 GB en S3

**Solución**: El free tier dura 12 meses. Para la mayoría de apps pequeñas/medianas, el free tier es suficiente.

---

## ✅ Checklist de Costos

### Antes de Lanzar
- [ ] Apple Developer Program: $99/año
- [ ] Google Play Developer: $25 (pago único)
- [ ] Verificar que Firebase esté en plan gratis
- [ ] Verificar que AWS esté en free tier

### Después de Lanzar (Monitorear)
- [ ] Revisar uso de Firebase mensualmente
- [ ] Revisar uso de AWS mensualmente
- [ ] Actualizar planes si es necesario

---

## 💡 Consejos para Minimizar Costos

1. **Empieza con planes gratuitos**: Firebase y AWS tienen generosos free tiers
2. **Monitorea el uso**: Revisa mensualmente para evitar sorpresas
3. **Optimiza las notificaciones**: No envíes más de las necesarias
4. **Usa caché**: Reduce llamadas a APIs
5. **Comprime imágenes**: Reduce uso de almacenamiento

---

## 📊 Resumen Final

**Costo Mínimo para Lanzar:**
- **$124 USD** (Año 1)
- **$99 USD/año** (Años siguientes)

**Costo Promedio (con uso moderado):**
- **$300-500 USD** (Año 1)
- **$200-300 USD/año** (Años siguientes)

**La mayoría de apps pequeñas/medianas pueden operar con el mínimo ($124 el primer año, $99/año después).**

