import 'package:flutter/material.dart';
import 'notification_service.dart';
import '../navigation/main_navigation.dart';

// Importar Firebase para Android e iOS
import 'package:firebase_messaging/firebase_messaging.dart' if (dart.library.io) 'package:firebase_messaging/firebase_messaging.dart';

/// Handler para notificaciones cuando la app está en segundo plano
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Notificación recibida en segundo plano: ${message.messageId}');
  debugPrint('Título: ${message.notification?.title}');
  debugPrint('Cuerpo: ${message.notification?.body}');
  debugPrint('Datos: ${message.data}');
  
  // NO mostrar notificación local si Firebase ya tiene notification en el payload
  // Firebase automáticamente muestra la notificación cuando hay 'notification' en el payload
  // Solo mostrar notificación local si SOLO hay 'data' sin 'notification'
  if (message.notification == null && message.data.isNotEmpty) {
    // Inicializar el servicio de notificaciones locales solo si es necesario
    await NotificationService().initialize();
    
    // Si solo hay datos sin notification, mostrar notificación con los datos
    final notificationType = message.data['type'] ?? 'general';
    final title = message.data['title'] ?? 'CCI San Pedro Sula';
    final body = message.data['body'] ?? 'Nueva notificación';
    
    await NotificationService().showNotification(
      id: message.hashCode,
      title: title,
      body: body,
      payload: notificationType,
    );
    debugPrint('Notificación mostrada desde datos en segundo plano (sin notification en payload)');
  } else {
    debugPrint('Notificación manejada automáticamente por Firebase (tiene notification en payload)');
  }
}

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  FirebaseMessaging? _messaging;
  String? _fcmToken;
  bool _initialized = false;
  GlobalKey<NavigatorState>? _navigatorKey;
  
  // Guardar mensaje inicial para navegar cuando MainNavigation esté listo
  static RemoteMessage? _pendingInitialMessage;
  static String? _pendingNotificationPayload;

  /// Establece la clave de navegación para poder navegar desde notificaciones
  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  /// Inicializa el servicio FCM
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      _messaging = FirebaseMessaging.instance;
      
      // Solicitar permisos
      NotificationSettings settings = await _messaging!.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('Usuario autorizó notificaciones');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        debugPrint('Usuario autorizó notificaciones provisionales');
      } else {
        debugPrint('Usuario rechazó o no autorizó notificaciones');
        return;
      }

      // Configurar handler para segundo plano
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Configurar handlers para cuando la app está en primer plano
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Obtener token FCM
      _fcmToken = await _messaging!.getToken();
      debugPrint('FCM Token: $_fcmToken');

      // Escuchar cambios en el token
      _messaging!.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        debugPrint('Nuevo FCM Token: $newToken');
      });

      // Verificar si la app fue abierta desde una notificación
      RemoteMessage? initialMessage = await _messaging!.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('App abierta desde notificación: ${initialMessage.messageId}');
        debugPrint('Datos: ${initialMessage.data}');
        // Guardar el mensaje para navegar cuando MainNavigation esté listo
        _pendingInitialMessage = initialMessage;
        // Intentar navegar después de un delay para dar tiempo a que la app se inicialice
        Future.delayed(const Duration(milliseconds: 2000), () {
          _handlePendingNavigation();
        });
      }

      _initialized = true;
    } catch (e) {
      debugPrint('Error inicializando FCM: $e');
      _initialized = true; // Marcar como inicializado para no intentar de nuevo
    }
  }

  /// Maneja notificaciones cuando la app está en primer plano
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Notificación recibida en primer plano: ${message.messageId}');
    debugPrint('Datos de la notificación: ${message.data}');
    
    // Mostrar notificación local con datos para navegación
    if (message.notification != null) {
      final notificationType = message.data['type'];
      NotificationService().showNotification(
        id: message.hashCode,
        title: message.notification!.title ?? 'CCI San Pedro Sula',
        body: message.notification!.body ?? '',
        payload: notificationType, // Pasar el tipo como payload para navegación
      );
    }
  }

  /// Maneja cuando el usuario toca una notificación
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Usuario tocó la notificación: ${message.messageId}');
    debugPrint('Datos de la notificación: ${message.data}');
    final notificationType = message.data['type'];
    debugPrint('Tipo de notificación: $notificationType');
    
    // Guardar el mensaje para navegar
    _pendingInitialMessage = message;
    _handlePendingNavigation();
  }
  
  /// Maneja la navegación pendiente cuando MainNavigation esté listo
  void _handlePendingNavigation() {
    RemoteMessage? message = _pendingInitialMessage;
    String? payload = _pendingNotificationPayload;
    
    if (message != null) {
      final notificationType = message.data['type'];
      debugPrint('Procesando navegación pendiente: $notificationType');
      
      if (notificationType == 'live_stream') {
        _navigateToScreen(4);
      } else if (notificationType == 'new_event') {
        _navigateToScreen(1);
      } else {
        debugPrint('Tipo de notificación desconocido: $notificationType');
      }
      
      // Limpiar el mensaje pendiente después de procesarlo
      _pendingInitialMessage = null;
    } else if (payload != null) {
      debugPrint('Procesando navegación desde payload: $payload');
      
      if (payload == 'live_stream') {
        _navigateToScreen(4);
      } else if (payload == 'new_event') {
        _navigateToScreen(1);
      }
      
      _pendingNotificationPayload = null;
    }
  }
  
  /// Método público para que MainNavigation notifique cuando esté listo
  void onMainNavigationReady() {
    debugPrint('MainNavigation está listo, verificando navegación pendiente...');
    Future.delayed(const Duration(milliseconds: 500), () {
      _handlePendingNavigation();
    });
  }
  
  /// Método para navegar desde notificaciones locales
  void navigateFromLocalNotification(String? payload) {
    if (payload != null) {
      _pendingNotificationPayload = payload;
      _handlePendingNavigation();
    }
  }

  /// Navega a una pantalla específica usando el PageController de MainNavigation
  void _navigateToScreen(int screenIndex) {
    debugPrint('Intentando navegar a pantalla índice: $screenIndex');
    
    // Intentar navegar directamente usando el método estático
    try {
      MainNavigation.navigateToPage(screenIndex);
      debugPrint('Navegación exitosa usando MainNavigation.navigateToPage');
      return;
    } catch (e) {
      debugPrint('Error navegando directamente: $e');
    }
    
    // Si falla, verificar si MainNavigation está montado usando NavigatorKey
    if (_navigatorKey?.currentState == null) {
      debugPrint('NavigatorKey no está disponible, reintentando en 1 segundo...');
      Future.delayed(const Duration(milliseconds: 1000), () {
        _navigateToScreen(screenIndex);
      });
      return;
    }
    
    final context = _navigatorKey!.currentContext;
    if (context == null) {
      debugPrint('Context no está disponible, reintentando en 1 segundo...');
      Future.delayed(const Duration(milliseconds: 1000), () {
        _navigateToScreen(screenIndex);
      });
      return;
    }

    // Verificar si MainNavigation está montado
    final mainNavigation = context.findAncestorWidgetOfExactType<MainNavigation>();
    
    if (mainNavigation != null) {
      // MainNavigation está montado, navegar directamente
      debugPrint('MainNavigation encontrado, navegando directamente');
      MainNavigation.navigateToPage(screenIndex);
    } else {
      // MainNavigation no está montado, navegar primero a MainNavigation
      debugPrint('MainNavigation no encontrado, navegando primero a MainNavigation');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainNavigation(),
        ),
        (route) => false,
      );
      
      // Esperar a que MainNavigation esté montado y luego navegar
      Future.delayed(const Duration(milliseconds: 1000), () {
        debugPrint('Intentando navegar después de montar MainNavigation');
        MainNavigation.navigateToPage(screenIndex);
        
        // Si aún no funciona, intentar de nuevo
        Future.delayed(const Duration(milliseconds: 800), () {
          MainNavigation.navigateToPage(screenIndex);
        });
      });
    }
  }

  /// Obtiene el token FCM actual
  String? getToken() => _fcmToken;

  /// Suscribe a un tema (opcional)
  Future<void> subscribeToTopic(String topic) async {
    if (_messaging == null) return;
    try {
      await _messaging!.subscribeToTopic(topic);
      debugPrint('Suscrito al tema: $topic');
    } catch (e) {
      debugPrint('Error suscribiéndose al tema: $e');
    }
  }

  /// Cancela suscripción a un tema
  Future<void> unsubscribeFromTopic(String topic) async {
    if (_messaging == null) return;
    try {
      await _messaging!.unsubscribeFromTopic(topic);
      debugPrint('Cancelada suscripción al tema: $topic');
    } catch (e) {
      debugPrint('Error cancelando suscripción al tema: $e');
    }
  }
}
