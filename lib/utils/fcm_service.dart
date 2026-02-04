import 'dart:convert';
import 'package:flutter/material.dart';
import 'notification_service.dart';
import '../navigation/main_navigation.dart';
import '../pantallas/alive.dart';
import '../pantallas/shift.dart';

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

  /// Datos de navegación pendiente (pantalla + evento) para que la pantalla destino los consuma
  static String? pendingEventId;
  static String? pendingCategory;

  /// True si la app se abrió desde una notificación (permite saltar Welcome)
  static bool get hasPendingNotification =>
      _pendingInitialMessage != null || _pendingNotificationPayload != null;

  /// En Android getInitialMessage() a veces no está listo al inicio. Reintentar con delay.
  Future<void> ensureInitialMessage() async {
    if (_pendingInitialMessage != null || _messaging == null) return;
    try {
      RemoteMessage? message = await _messaging!.getInitialMessage();
      if (message == null) {
        await Future.delayed(const Duration(milliseconds: 800));
        message = await _messaging!.getInitialMessage();
      }
      if (message != null) {
        debugPrint('ensureInitialMessage: mensaje obtenido (cold start)');
        debugPrint('Datos: ${message.data}');
        _pendingInitialMessage = message;
      }
    } catch (e) {
      debugPrint('ensureInitialMessage error: $e');
    }
  }

  /// Devuelve y limpia los datos de evento pendiente para la pantalla que los consuma
  static Map<String, String>? consumePendingEventNavigation() {
    final eventId = pendingEventId;
    final category = pendingCategory;
    pendingEventId = null;
    pendingCategory = null;
    if (eventId == null || eventId.isEmpty) return null;
    return {'eventId': eventId, 'category': category ?? 'general'};
  }

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

      // Verificar si la app fue abierta desde una notificación (app cerrada o en segundo plano)
      RemoteMessage? initialMessage = await _messaging!.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('App abierta desde notificación: ${initialMessage.messageId}');
        debugPrint('Datos: ${initialMessage.data}');
        _pendingInitialMessage = initialMessage;
        // No llamar _handlePendingNavigation aquí: SplashScreen llevará a MainNavigation
        // y onMainNavigationReady() lo hará cuando el tab esté listo.
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
    
    if (message.notification != null) {
      final category = (message.data['category'] ?? 'general').toString();
      final eventId = (message.data['eventId'] ?? message.data['eventID'] ?? '').toString();
      // Payload con category y eventId para que al tocar la notificación local vaya a la pantalla correcta
      final payload = jsonEncode({
        'type': message.data['type'] ?? 'new_event',
        'category': category,
        'eventId': eventId,
      });
      NotificationService().showNotification(
        id: message.hashCode,
        title: message.notification!.title ?? 'CCI San Pedro Sula',
        body: message.notification!.body ?? '',
        payload: payload,
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
      _applyNavigationFromData(message.data);
      _pendingInitialMessage = null;
    } else if (payload != null) {
      debugPrint('Procesando navegación desde payload: $payload');
      _pendingNotificationPayload = null;
      if (payload.trim().startsWith('{')) {
        try {
          final data = jsonDecode(payload) as Map<String, dynamic>;
          final type = (data['type'] ?? 'new_event').toString();
          final category = (data['category'] ?? 'general').toString().toLowerCase();
          final eventId = (data['eventId'] ?? '').toString();
          _applyNavigationFromData({'type': type, 'category': category, 'eventId': eventId});
        } catch (e) {
          debugPrint('Error parseando payload JSON: $e');
          if (payload == 'live_stream') _navigateToScreen(4);
          else if (payload == 'new_event') _navigateToScreen(1);
        }
      } else {
        if (payload == 'live_stream') _navigateToScreen(4);
        else if (payload == 'new_event') {
          pendingCategory = 'general';
          _navigateToScreen(1);
        }
      }
    }
  }

  void _applyNavigationFromData(Map<String, dynamic> data) {
    final notificationType = data['type'];
    final category = (data['category'] ?? '').toString().toLowerCase();
    final eventId = (data['eventId'] ?? data['eventID'] ?? '').toString();
    debugPrint('Navegación: type=$notificationType, category=$category, eventId=$eventId');
    
    if (notificationType == 'live_stream') {
      _navigateToScreen(4);
      return;
    }
    if (notificationType == 'new_event') {
      pendingEventId = eventId.isNotEmpty ? eventId : null;
      pendingCategory = category.isNotEmpty ? category : 'general';
      if (category == 'alive' || category == 'shift') {
        // No ir al tab Ministerios: push directo a Alive/Shift para que al volver atrás no quede Ministerios
        Future.delayed(const Duration(milliseconds: 500), () {
          final state = _navigatorKey?.currentState;
          if (state != null && state.mounted) {
            if (category == 'alive') {
              state.push(MaterialPageRoute(builder: (_) => const Alive()));
            } else {
              state.push(MaterialPageRoute(builder: (_) => const Shift()));
            }
          }
        });
      } else {
        final index = _eventCategoryToPageIndex(category);
        _navigateToScreen(index);
      }
      return;
    }
    debugPrint('Tipo de notificación desconocido: $notificationType');
  }

  /// general -> Eventos(1), next -> Next(7). alive/shift se manejan con push directo (sin tab Ministerios).
  int _eventCategoryToPageIndex(String category) {
    switch (category) {
      case 'next':
        return 7;
      case 'alive':
      case 'shift':
        return 0;
      default:
        return 1;
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
