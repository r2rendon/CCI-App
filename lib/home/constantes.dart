import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cci_app/home/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          primarySwatch: Colors.blue,
          useMaterial3: true,
          fontFamily: 'SF Pro Display',
        ),
        home: const SplashScreen(),
      );
}

// Colores principales
const Color negro = Color.fromARGB(255, 0, 0, 0);
const Color gris = Color.fromARGB(255, 44, 49, 51);
const Color blanco = Color.fromARGB(255, 255, 255, 255);
const Color barr = Color.fromARGB(64, 255, 255, 255);
const Color grisClaro = Color.fromARGB(255, 128, 128, 128);
const Color azulPrimario = Color.fromARGB(255, 33, 150, 243);

// Nuevos colores para Welcome Screen
const Color beigeClaro = Color(0xFFF5F5DC);
const Color grisOscuro = Color(0xFF2C2C2C);

// Gradientes
const decorations = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      gris,
      negro,
    ],
  ),
);

const decorationsAlt = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      negro,
      gris,
    ],
  ),
);

// Tipografías responsivas mejoradas
TextStyle getThema(double screenWidth) {
  double fontSize = screenWidth < 360 ? 16 : 18;
  return const TextStyle(
    color: blanco,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
  ).copyWith(fontSize: fontSize);
}

TextStyle getTitulo(double screenWidth) {
  double fontSize = screenWidth < 360 ? 28 : 35;
  return const TextStyle(
    height: 0,
    color: blanco,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w700,
  ).copyWith(fontSize: fontSize);
}

// Padding responsivo mejorado
double getHorizontalPadding(double screenWidth) {
  if (screenWidth < 360) return 16;
  if (screenWidth < 600) return 24;
  if (screenWidth < 900) return 32;
  return 40;
}

double getVerticalPadding(double screenWidth) {
  if (screenWidth < 360) return 12;
  if (screenWidth < 600) return 16;
  if (screenWidth < 900) return 20;
  return 24;
}

// Función para SafeArea responsivo
EdgeInsets getSafeAreaPadding(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  return EdgeInsets.only(
    top: mediaQuery.padding.top,
    bottom: mediaQuery.padding.bottom,
    left: mediaQuery.padding.left,
    right: mediaQuery.padding.right,
  );
}

// Constantes para diferentes tamaños de pantalla
const double smallScreenWidth = 360;
const double mediumScreenWidth = 600;
const double largeScreenWidth = 900;

// Duración de animaciones
const Duration duracion = Duration(milliseconds: 300);
const Duration duracionLarga = Duration(milliseconds: 500);

// Espaciado estándar
const double defaultPadding = 16.0;
const double smallPadding = 8.0;
const double largePadding = 24.0;

// Radio de bordes
const double borderRadius = 12.0;
const double borderRadiusSmall = 8.0;
const double borderRadiusLarge = 16.0;

// Sombras
const List<BoxShadow> defaultShadow = [
  BoxShadow(
    color: Color.fromARGB(20, 0, 0, 0),
    blurRadius: 10,
    offset: Offset(0, 2),
  ),
];

// Constantes para navegación
const double navigationBarHeight = 80.0;
const double appBarHeight = 56.0;

// Utilidad para opacidad compatible
Color colorWithOpacity(Color color, double opacity) {
  return Color.fromARGB(
    (opacity * 255).round(),
    (color.r * 255).round(),
    (color.g * 255).round(),
    (color.b * 255).round(),
  );
}

// Función para determinar si es tablet
bool isTablet(double screenWidth) {
  return screenWidth >= 600;
}

// Función para determinar si es desktop
bool isDesktop(double screenWidth) {
  return screenWidth >= 900;
}

// Función para obtener tamaño de fuente responsivo
double getResponsiveFontSize(double screenWidth, double baseFontSize) {
  if (screenWidth < 360) return baseFontSize * 0.9;
  if (screenWidth < 600) return baseFontSize;
  if (screenWidth < 900) return baseFontSize * 1.1;
  return baseFontSize * 1.2;
}
