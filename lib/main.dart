import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cci_app/home/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- INICIO: Bloque comentado para pruebas ---
  /*
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  try {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  } catch (e) {
    debugPrint('Error inicializando notificaciones: ' + e.toString());
  }
  */
  // --- FIN: Bloque comentado para pruebas ---

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CCI San Pedro Sula',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'SF Pro Display', // Fallback: 'Roboto' o 'System'
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            displayMedium: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            displaySmall: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            headlineLarge: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            headlineMedium: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            headlineSmall: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            titleLarge: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            titleMedium: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            titleSmall: TextStyle(
                fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700),
            bodyLarge: TextStyle(fontFamily: 'SF Pro Display'),
            bodyMedium: TextStyle(fontFamily: 'SF Pro Display'),
            bodySmall: TextStyle(fontFamily: 'SF Pro Display'),
            labelLarge: TextStyle(fontFamily: 'SF Pro Display'),
            labelMedium: TextStyle(fontFamily: 'SF Pro Display'),
            labelSmall: TextStyle(fontFamily: 'SF Pro Display'),
          ),
        ),
        home: const SplashScreen(),
      );
}
