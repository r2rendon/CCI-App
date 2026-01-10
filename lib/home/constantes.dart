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

// Paleta estilo lujo elegante (basada en referencia)
const Color negro = Color(0xFF000000);
const Color blanco = Color(0xFFFFFFFF);
const Color grisClaro = Color(0xFFF5F5F7);
const Color grisMedio = Color(0xFF8E8E93);
const Color grisOscuro = Color(0xFF1C1C1E);
const Color grisFondo = Color(0xFF1A1A1A); // Gris oscuro elegante
const Color grisCard = Color(0xFF2A2A2A); // Para cards
const Color primario = Color(0xFFFFFFFF); // Blanco para acentos
const Color primarioOscuro = Color(0xFFE0E0E0);
const Color accent =
    Color(0xFF007AFF); // Azul sutil para elementos interactivos

// Compatibilidad con código existente
const Color gris = grisOscuro;
const Color azulPrimario = primario;
const Color barr = Color.fromARGB(64, 255, 255, 255);

// Gradientes elegantes
const decorations = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      grisFondo,
      Color(0xFF161616),
      negro,
    ],
    stops: const [0.0, 0.6, 1.0],
  ),
);

const decorationsAlt = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      grisFondo,
      Color(0xFF161616),
      negro,
    ],
    stops: const [0.0, 0.5, 1.0],
  ),
);

// Helper para aplicar gradiente de fondo
BoxDecoration getGradientBackground() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        grisFondo,
        Color(0xFF161616),
        negro,
      ],
      stops: [0.0, 0.6, 1.0],
    ),
  );
}

// Tipografías minimalistas SF Pro Display
TextStyle getThema(double screenWidth) {
  double fontSize = screenWidth < 360 ? 15 : 17;
  return const TextStyle(
    color: blanco,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    height: 1.35,
    decoration: TextDecoration.none,
  ).copyWith(fontSize: fontSize);
}

TextStyle getTitulo(double screenWidth) {
  double fontSize = screenWidth < 360 ? 42 : 56;
  return const TextStyle(
    color: blanco,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.1,
    decoration: TextDecoration.none,
  ).copyWith(fontSize: fontSize);
}

TextStyle getHeroSubtitle(double screenWidth) {
  double fontSize = screenWidth < 360 ? 11 : 13;
  return const TextStyle(
    color: grisMedio,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
    height: 1.2,
    decoration: TextDecoration.none,
  ).copyWith(fontSize: fontSize);
}

TextStyle getHeroDescription(double screenWidth) {
  double fontSize = screenWidth < 360 ? 15 : 17;
  return const TextStyle(
    color: grisMedio,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.6,
    decoration: TextDecoration.none,
  ).copyWith(fontSize: fontSize);
}

TextStyle getSubtitulo(double screenWidth) {
  double fontSize = screenWidth < 360 ? 20 : 24;
  return const TextStyle(
    color: grisMedio,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w500,
    letterSpacing: 0.38,
    height: 1.2,
    decoration: TextDecoration.none,
  ).copyWith(fontSize: fontSize);
}

// Padding responsivo mejorado para todos los dispositivos
double getHorizontalPadding(double screenWidth) {
  // Móviles pequeños
  if (screenWidth < 360) return 20;
  // Móviles estándar
  if (screenWidth < 400) return 24;
  // Móviles grandes
  if (screenWidth < 600) return 32;
  // Tablets pequeñas
  if (screenWidth < 900) return 48;
  // Tablets grandes / Desktop
  return 64;
}

double getVerticalPadding(double screenWidth) {
  // Móviles pequeños
  if (screenWidth < 360) return 16;
  // Móviles estándar
  if (screenWidth < 400) return 20;
  // Móviles grandes
  if (screenWidth < 600) return 24;
  // Tablets
  if (screenWidth < 900) return 32;
  // Desktop
  return 40;
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

// Duración de animaciones sutiles
const Duration duracion = Duration(milliseconds: 350);
const Duration duracionLarga = Duration(milliseconds: 600);
const Duration duracionCorta = Duration(milliseconds: 200);
const Curve curvaSuave = Curves.easeOutCubic;
const Curve curvaNatural = Curves.easeInOut;

// Espaciado estándar
const double defaultPadding = 16.0;
const double smallPadding = 8.0;
const double largePadding = 24.0;

// Radio de bordes minimalistas
const double borderRadius = 16.0;
const double borderRadiusSmall = 12.0;
const double borderRadiusLarge = 20.0;
const double borderRadiusXL = 28.0;

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
  return color.withValues(
      alpha: ((color.alpha / 255.0) * opacity).clamp(0.0, 1.0));
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
