import 'package:flutter/material.dart';

class AppConfig {
  // Configuraciones de la app
  static const String appName = 'CCI San Pedro Sula';
  static const String appVersion = '1.0.0';

  // URLs y enlaces
  static const String whatsappNumber = '31750015';
  static const String phoneNumber = '+504 2510-1731';
  static const String mapsUrl = 'https://maps.app.goo.gl/dxPGGHJEZFQPBgJt8';
  static const String kiloBistroUrl =
      'https://www.google.com/maps/place/Kilo+Bistro/@15.5368038,-88.0413544,17z/data=!3m1!4b1!4m6!3m5!1s0x8f665b414c15ac45:0xc6f3e6b4517ae5df!8m2!3d15.5368038!4d-88.0413544!16s%2Fg%2F11s9whqklr?entry=ttu';

  // Redes sociales
  static const Map<String, String> socialMedia = {
    'alive': 'https://www.instagram.com/alive.cci',
    'next': 'https://www.instagram.com/next.cci',
    'shift': 'https://www.instagram.com/shift.cci',
    'matrimonios': 'https://www.instagram.com/matrimonios.cci',
    'mujeres': 'https://www.instagram.com/mujeres.cci',
    'hombres': 'https://www.facebook.com/hombres.cci',
  };

  // Videos de YouTube
  static const String liveVideoId = 'zyrzZK0eKKI';
  static const String recentVideoId = 'c5GWRFVO9MM';

  // Configuraciones de animación
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration transitionDuration = Duration(milliseconds: 300);
  static const Duration longTransitionDuration = Duration(milliseconds: 500);

  // Configuraciones de pantalla
  static const double minScreenWidth = 360;
  static const double mediumScreenWidth = 600;
  static const double largeScreenWidth = 900;

  // Configuraciones de diseño
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  // Colores de marca
  static const Color whatsappColor = Color(0xFF25D366);
  static const Color mapsColor = Color(0xFF4285F4);
  static const Color phoneColor = Color(0xFF2196F3);

  // Configuraciones de notificaciones
  static const String notificationChannelId = 'cci_notifications';
  static const String notificationChannelName = 'CCI Notifications';
  static const String notificationChannelDescription =
      'Notificaciones de CCI San Pedro Sula';

  // Mensajes de error
  static const Map<String, String> errorMessages = {
    'whatsapp': 'No se pudo abrir WhatsApp',
    'maps': 'No se pudo abrir Maps',
    'phone': 'No se pudo realizar la llamada',
    'social': 'No se pudo abrir la red social',
    'video': 'No se pudo cargar el video',
    'image': 'No se pudo cargar la imagen',
    'network': 'Error de conexión',
    'general': 'Ocurrió un error inesperado',
  };

  // Configuraciones de carga
  static const Duration loadingTimeout = Duration(seconds: 10);
  static const Duration refreshTimeout = Duration(seconds: 5);

  // Configuraciones de caché
  static const Duration imageCacheDuration = Duration(days: 7);
  static const Duration dataCacheDuration = Duration(hours: 1);

  // Configuraciones de seguridad
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePerformanceMonitoring = true;

  // Configuraciones de accesibilidad
  static const double minTouchTargetSize = 44.0;
  static const double minTextSize = 12.0;
  static const double maxTextSize = 24.0;

  // Configuraciones de rendimiento
  static const int maxImageCacheSize = 100;
  static const int maxMemoryCacheSize = 50;
  static const bool enableImageCompression = true;

  // Configuraciones de idioma
  static const String defaultLanguage = 'es';
  static const List<String> supportedLanguages = ['es', 'en'];

  // Configuraciones de región
  static const String defaultRegion = 'HN';
  static const String defaultTimezone = 'America/Tegucigalpa';

  // Configuraciones de moneda
  static const String defaultCurrency = 'HNL';
  static const String currencySymbol = 'L.';

  // Configuraciones de fecha
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  // Configuraciones de validación
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;
  static const int minPhoneLength = 8;
  static const int maxPhoneLength = 15;

  // Configuraciones de paginación
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;
  static const int minPageSize = 5;

  // Configuraciones de búsqueda
  static const int searchDebounceMs = 300;
  static const int searchMinLength = 2;
  static const int searchMaxResults = 20;

  // Configuraciones de sincronización
  static const Duration syncInterval = Duration(minutes: 15);
  static const Duration syncTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;

  // Configuraciones de backup
  static const bool enableAutoBackup = true;
  static const Duration backupInterval = Duration(days: 1);
  static const int maxBackupFiles = 7;

  // Configuraciones de logging
  static const bool enableDebugLogging = true;
  static const bool enableErrorLogging = true;
  static const bool enablePerformanceLogging = true;
  static const int maxLogEntries = 1000;

  // Configuraciones de desarrollo
  static const bool enableHotReload = true;
  static const bool enableDevTools = true;
  static const bool enableDebugBanner = false;

  // Configuraciones de producción
  static const bool enableProductionMode = false;
  static const bool enableStrictMode = false;
  static const bool enableOptimizations = true;
}
