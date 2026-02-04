import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../utils/app_config.dart';
import 'fcm_service.dart';

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
    
    // Usar FCMService para manejar la navegación (tiene mejor manejo de estados)
    if (response.payload != null) {
      final fcmService = FCMService();
      fcmService.navigateFromLocalNotification(response.payload);
    }
  }

  /// Programa notificaciones recurrentes para celebraciones
  Future<void> scheduleRecurringNotifications() async {
    // Domingos: una sola notificación 40 min antes de cada celebración
    await scheduleSundayNotifications();
    // Miércoles: 9h antes + a las 7:00 PM (cada miércoles; primer miércoles = Ayuno y Oración)
    await scheduleWednesdayNotifications();
  }

  /// Domingos: una notificación 40 min antes de 9:00 AM y una 40 min antes de 11:30 AM
  Future<void> scheduleSundayNotifications() async {
    // 40 min antes de 9:00 = 8:20
    await scheduleWeeklyNotification(
      id: 1,
      title: 'Celebración Semanal',
      body: 'Celebración Semanal 9:00 AM',
      day: DateTime.sunday,
      hour: 8,
      minute: 20,
    );
    // 40 min antes de 11:30 = 10:50
    await scheduleWeeklyNotification(
      id: 2,
      title: 'Celebración Semanal',
      body: 'Celebración Semanal 11:30 AM',
      day: DateTime.sunday,
      hour: 10,
      minute: 50,
    );
  }

  /// Miércoles: para cada miércoles, 2 notificaciones — 9h antes (10:00) y a las 19:00
  /// Primer miércoles del mes = Ayuno y Oración (se transmite); el resto = Celebración de Oración
  Future<void> scheduleWednesdayNotifications() async {
    if (!_initialized) await initialize();

    final now = tz.TZDateTime.now(tz.local);
    const int baseId = 1000;
    int id = baseId;

    // Próximos 12 meses, todos los miércoles
    for (int i = 0; i < 12; i++) {
      final monthStart = DateTime(now.year, now.month + i, 1);
      final wednesdays = _wednesdaysInMonth(monthStart.year, monthStart.month);
      for (final wed in wednesdays) {
        final wed10am = tz.TZDateTime(tz.local, wed.year, wed.month, wed.day, 10, 0);
        final wed7pm = tz.TZDateTime(tz.local, wed.year, wed.month, wed.day, 19, 0);
        if (wed10am.isBefore(now) && wed7pm.isBefore(now)) continue;

        final isFirstWednesday = _isFirstWednesdayOfMonth(wed.year, wed.month, wed.day);
        final String title;
        final String body9h;
        final String body7pm;
        if (isFirstWednesday) {
          title = 'Celebración de Ayuno y Oración';
          body9h = 'Recordatorio: Celebración de Ayuno y Oración. Unámonos con un mismo corazón para buscar la presencia de Dios.\n Celebración: 7:00 p.m.\n Les esperamos en CCI San Pedro Sula.'; //Modificar este mensaje'
          body7pm = 'Celebración de Ayuno y Oración 7:00 PM';
        } else {
          title = 'Celebración de Oración';
          body9h = 'Recordatorio: Celebración de Oración. Unámonos con un mismo corazón para buscar la presencia de Dios..\n Celebración: 7:00 p.m.\n Les esperamos en CCI San Pedro Sula.';
          body7pm = 'Celebración de Oración 7:00 PM';
        }

        if (wed10am.isAfter(now)) {
          await _scheduleOne(
            id: id++,
            title: title,
            body: body9h,
            scheduled: wed10am,
          );
        }
        if (wed7pm.isAfter(now)) {
          await _scheduleOne(
            id: id++,
            title: title,
            body: body7pm,
            scheduled: wed7pm,
          );
        }
      }
    }
  }

  /// Lista de todos los miércoles del mes (DateTime en hora local)
  List<DateTime> _wednesdaysInMonth(int year, int month) {
    final first = DateTime(year, month, 1);
    final daysToFirstWed = (3 - first.weekday + 7) % 7;
    final firstWed = first.add(Duration(days: daysToFirstWed));
    final list = <DateTime>[];
    for (var d = firstWed; d.month == month; d = d.add(const Duration(days: 7))) {
      list.add(d);
    }
    return list;
  }

  bool _isFirstWednesdayOfMonth(int year, int month, int day) {
    final first = DateTime(year, month, 1);
    final daysToFirstWed = (3 - first.weekday + 7) % 7;
    return 1 + daysToFirstWed == day;
  }

  Future<void> _scheduleOne({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduled,
  }) async {
    try {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        scheduled,
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
      try {
        await _notifications.zonedSchedule(
          id,
          title,
          body,
          scheduled,
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
      } catch (e2) {
        print('Error programando notificación $id: $e2');
      }
    }
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

