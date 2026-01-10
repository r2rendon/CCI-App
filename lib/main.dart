import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'home/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Deshabilitar visualización de errores de overflow en modo debug
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (details.exception is FlutterError &&
        details.exception.toString().contains('overflow')) {
      return const SizedBox.shrink();
    }
    return ErrorWidget(details.exception);
  };

  // Configuración de orientación y UI para pantalla completa
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

  // Configuración de notificaciones
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  try {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  } catch (e) {
    debugPrint('Error inicializando notificaciones: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CCI San Pedro Sula',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SF Pro Display',
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF121212),
          primaryColor: const Color(0xFF007AFF),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF007AFF),
            secondary: Color(0xFF5856D6),
            surface: Color(0xFF1C1C1E),
            error: Color(0xFFFF3B30),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onError: Colors.white,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 40,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.37,
              color: Colors.white,
              height: 1.1,
              decoration: TextDecoration.none,
            ),
            displayMedium: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.37,
              color: Colors.white,
              height: 1.1,
              decoration: TextDecoration.none,
            ),
            displaySmall: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.36,
              color: Colors.white,
              height: 1.2,
              decoration: TextDecoration.none,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.38,
              color: Colors.white,
              height: 1.2,
              decoration: TextDecoration.none,
            ),
            titleLarge: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.38,
              color: Colors.white,
              height: 1.25,
              decoration: TextDecoration.none,
            ),
            titleMedium: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.41,
              color: Colors.white,
              height: 1.35,
              decoration: TextDecoration.none,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.41,
              color: Colors.white,
              height: 1.35,
              decoration: TextDecoration.none,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.24,
              color: Colors.white,
              height: 1.4,
              decoration: TextDecoration.none,
            ),
            bodySmall: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.08,
              color: Color(0xFF8E8E93),
              height: 1.4,
              decoration: TextDecoration.none,
            ),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        home: const SplashScreen(),
      );
}
