import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../utils/app_config.dart';
import '../navigation/main_navigation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Inicializa el servicio de notificaciones
  Future<void> initialize() async {
    if (_initialized) return;

    // Inicializar timezone
    tz.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('America/Tegucigalpa'));
    } catch (e) {
      // Si falla, usar UTC
      tz.setLocalLocation(tz.UTC);
    }

    // Configuración para Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración para iOS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Crear canal de notificaciones para Android
    await _createNotificationChannel();

    _initialized = true;

    // Programar notificaciones recurrentes (con manejo de errores)
    try {
      await scheduleRecurringNotifications();
    } catch (e) {
      print('Error programando notificaciones recurrentes: $e');
      // Continuar sin las notificaciones programadas si fallan
    }
  }

  /// Crea el canal de notificaciones para Android
  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      AppConfig.notificationChannelId,
      AppConfig.notificationChannelName,
      description: AppConfig.notificationChannelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Maneja el tap en las notificaciones
  void _onNotificationTapped(NotificationResponse response) {
    print('Notificación presionada: ${response.id}, payload: ${response.payload}');
    
    // Navegar según el tipo de notificación (payload)
    if (response.payload != null) {
      final notificationType = response.payload;
      if (notificationType == 'live_stream') {
        // Navegar a la pantalla de Transmisiones (índice 4)
        _navigateFromNotification(4);
      } else if (notificationType == 'new_event') {
        // Navegar a la pantalla de Eventos (índice 1)
        _navigateFromNotification(1);
      }
    }
  }

  /// Navega desde una notificación local
  void _navigateFromNotification(int screenIndex) {
    // Importar MainNavigation dinámicamente para evitar dependencias circulares
    Future.delayed(const Duration(milliseconds: 300), () {
      try {
        // Usar el método estático de MainNavigation
        MainNavigation.navigateToPage(screenIndex);
      } catch (e) {
        print('Error navegando desde notificación: $e');
      }
    });
  }

  /// Programa notificaciones recurrentes para transmisiones en vivo
  Future<void> scheduleRecurringNotifications() async {
    // Notificación para servicio dominical - 9:00 AM
    await scheduleWeeklyNotification(
      id: 1,
      title: 'Servicio Dominical',
      body: 'Únete a nuestro servicio dominical a las 9:00 AM',
      day: DateTime.sunday,
      hour: 9,
      minute: 0,
    );

    // Notificación para transmisión dominical - 11:30 AM
    await scheduleWeeklyNotification(
      id: 2,
      title: 'Transmisión en Vivo',
      body: '¡Nuestra transmisión en vivo comienza a las 11:30 AM!',
      day: DateTime.sunday,
      hour: 11,
      minute: 30,
    );

    // Notificación para transmisión miércoles - 7:00 PM
    await scheduleWeeklyNotification(
      id: 3,
      title: 'Transmisión en Vivo',
      body: '¡Nuestra transmisión de miércoles comienza a las 7:00 PM!',
      day: DateTime.wednesday,
      hour: 19,
      minute: 0,
    );
  }

  /// Programa una notificación semanal recurrente
  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int day, // 1 = lunes, 7 = domingo
    required int hour,
    required int minute,
  }) async {
    if (!_initialized) await initialize();

    // Crear una fecha de referencia con el día de la semana y hora correctos
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = _nextInstanceOfDay(day, hour, minute);

    // Si la hora ya pasó esta semana, programar para la próxima semana
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    try {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            AppConfig.notificationChannelId,
            AppConfig.notificationChannelName,
            channelDescription: AppConfig.notificationChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: _getScheduleMode(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    } catch (e) {
      // Si falla con exact, intentar con inexact
      print('Error con exact alarm, usando inexact: $e');
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            AppConfig.notificationChannelId,
            AppConfig.notificationChannelName,
            channelDescription: AppConfig.notificationChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  /// Calcula la próxima instancia de un día de la semana a una hora específica
  tz.TZDateTime _nextInstanceOfDay(int dayOfWeek, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Ajustar al día de la semana correcto
    final daysUntilTarget = (dayOfWeek - scheduledDate.weekday + 7) % 7;
    if (daysUntilTarget > 0) {
      scheduledDate = scheduledDate.add(Duration(days: daysUntilTarget));
    } else if (daysUntilTarget == 0 && scheduledDate.isBefore(now)) {
      // Si es el mismo día pero ya pasó la hora, programar para la próxima semana
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }

  /// Programa una notificación para un evento específico
  Future<void> scheduleEventNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? location,
  }) async {
    if (!_initialized) await initialize();

    final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    // No programar si la fecha ya pasó
    if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      print('No se puede programar notificación para una fecha pasada');
      return;
    }

    // Notificación de recordatorio 1 día antes
    final reminderDate = tzScheduledDate.subtract(const Duration(days: 1));
    if (reminderDate.isAfter(tz.TZDateTime.now(tz.local))) {
      try {
        await _notifications.zonedSchedule(
          id,
          'Recordatorio: $title',
          location != null ? '$body\nUbicación: $location' : body,
          reminderDate,
          NotificationDetails(
            android: AndroidNotificationDetails(
              AppConfig.notificationChannelId,
              AppConfig.notificationChannelName,
              channelDescription: AppConfig.notificationChannelDescription,
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              enableVibration: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          androidScheduleMode: _getScheduleMode(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (e) {
        // Si falla con exact, usar inexact
        await _notifications.zonedSchedule(
          id,
          'Recordatorio: $title',
          location != null ? '$body\nUbicación: $location' : body,
          reminderDate,
          NotificationDetails(
            android: AndroidNotificationDetails(
              AppConfig.notificationChannelId,
              AppConfig.notificationChannelName,
              channelDescription: AppConfig.notificationChannelDescription,
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              enableVibration: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }

    // Notificación del día del evento
    try {
      await _notifications.zonedSchedule(
        id + 1000, // Offset para diferenciar del recordatorio
        title,
        location != null ? '$body\nUbicación: $location' : body,
        tzScheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            AppConfig.notificationChannelId,
            AppConfig.notificationChannelName,
            channelDescription: AppConfig.notificationChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: _getScheduleMode(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // Si falla con exact, usar inexact
      await _notifications.zonedSchedule(
        id + 1000,
        title,
        location != null ? '$body\nUbicación: $location' : body,
        tzScheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            AppConfig.notificationChannelId,
            AppConfig.notificationChannelName,
            channelDescription: AppConfig.notificationChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  /// Programa un recordatorio para una reunión de ministerio
  Future<void> scheduleMinistryReminder({
    required int id,
    required String ministryName,
    required String description,
    required DateTime scheduledDate,
    String? location,
  }) async {
    if (!_initialized) await initialize();

    final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    // No programar si la fecha ya pasó
    if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      print('No se puede programar notificación para una fecha pasada');
      return;
    }

    // Notificación 2 horas antes
    final reminderDate = tzScheduledDate.subtract(const Duration(hours: 2));
    if (reminderDate.isAfter(tz.TZDateTime.now(tz.local))) {
      try {
        await _notifications.zonedSchedule(
          id,
          'Recordatorio: Reunión de $ministryName',
          location != null
              ? '$description\nUbicación: $location'
              : description,
          reminderDate,
          NotificationDetails(
            android: AndroidNotificationDetails(
              AppConfig.notificationChannelId,
              AppConfig.notificationChannelName,
              channelDescription: AppConfig.notificationChannelDescription,
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              enableVibration: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          androidScheduleMode: _getScheduleMode(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (e) {
        // Si falla con exact, usar inexact
        await _notifications.zonedSchedule(
          id,
          'Recordatorio: Reunión de $ministryName',
          location != null
              ? '$description\nUbicación: $location'
              : description,
          reminderDate,
          NotificationDetails(
            android: AndroidNotificationDetails(
              AppConfig.notificationChannelId,
              AppConfig.notificationChannelName,
              channelDescription: AppConfig.notificationChannelDescription,
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              enableVibration: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  }

  /// Cancela una notificación programada
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// Cancela todas las notificaciones
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Muestra una notificación inmediata
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_initialized) await initialize();

    await _notifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          AppConfig.notificationChannelId,
          AppConfig.notificationChannelName,
          channelDescription: AppConfig.notificationChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  /// Obtiene las notificaciones pendientes
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  /// Obtiene el modo de programación según la disponibilidad de permisos
  /// En Android 12+ se requiere permiso SCHEDULE_EXACT_ALARM para alarmas exactas
  AndroidScheduleMode _getScheduleMode() {
    // Intentar usar exactAllowWhileIdle para mayor precisión
    // Si el permiso no está disponible, el sistema usará inexact automáticamente
    return AndroidScheduleMode.exactAllowWhileIdle;
  }
}

