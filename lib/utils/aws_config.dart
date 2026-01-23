// Configuración para AWS - No commitees este archivo con credenciales reales
class AWSConfig {
  // URL del endpoint de API Gateway
  static const String liveVideosEndpoint =
      'https://nmm5j8uu85.execute-api.us-east-2.amazonaws.com';

  // URL del endpoint para eventos
  static const String eventsEndpoint =
      'https://u29mw3l755.execute-api.us-east-2.amazonaws.com';

  // Configuración de caché
  static const Duration cacheDuration = Duration(minutes: 5);
}
