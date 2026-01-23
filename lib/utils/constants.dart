import 'package:flutter/material.dart';

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

// Colores adicionales
const Color beigeCream = Color(0xFFF5F5DC); // Beige/Crema usado en ubicación
const Color colorGrisIntermedio =
    Color(0xFF161616); // Gris intermedio en gradientes

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
  return color.withValues(alpha: (color.a * opacity).clamp(0.0, 1.0));
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

// ============================================
// TEXTOS COMUNES
// ============================================
const String kAppName = "CCI San Pedro Sula";
const String kLocationName = "San Pedro Sula";
const String kChurchName = "CENTRO CRISTIANO";
const String kChurchSubtitle = "INTERNACIONAL";
const String kChurchCity = "SAN PEDRO SULA";
const String kChurchFullName = "Centro Cristiano Internacional";
const String kChurchAddress =
    "International Christian Center San Pedro Sula\n21 Avenida C, Colonia Trejo, San Pedro Sula, Departamento de Cortés, Honduras.";

// Títulos de secciones
const String kSectionEvents = "Eventos";
const String kSectionChurch = "Seamos Iglesia";
const String kSectionMinistries = "Ministerios CCI";
const String kSectionLive = "En Vivo";
const String kSectionGive = "Dar";
const String kSectionNext = "Next";
const String kSectionLocation = "Ubicación";
const String kSectionExplore = "Explorar";

// Mensajes principales
const String kMainMessageLine1 = "MOSTREMOS";
const String kMainMessageLine2 = "EL AMOR";
const String kMainMessageLine3 = "DE DIOS";
const String kMainMessageLine4 = "PARA QUE EL MUNDO CREA";

// ============================================
// CONSTANTES DE TIPOGRAFÍA
// ============================================
const String kFontFamily = 'SF Pro Display';

// Font Weights
const FontWeight fontWeightLight = FontWeight.w300;
const FontWeight fontWeightRegular = FontWeight.w400;
const FontWeight fontWeightMedium = FontWeight.w500;
const FontWeight fontWeightSemiBold = FontWeight.w600;
const FontWeight fontWeightBold = FontWeight.w700;
const FontWeight fontWeightBlack = FontWeight.w900;

// Letter Spacing
const double letterSpacingTight = -1.0;
const double letterSpacingMedium = -0.5;
const double letterSpacingNormal = -0.41;
const double letterSpacingLoose = -0.3;
const double letterSpacingNone = 0.0;
const double letterSpacingWide = 0.3;
const double letterSpacingWider = 0.5;
const double letterSpacingWidest = 2.0;

// Line Heights
const double lineHeightTight = 0.95;
const double lineHeightNormal = 1.1;
const double lineHeightLoose = 1.2;
const double lineHeightComfortable = 1.35;
const double lineHeightRelaxed = 1.4;
const double lineHeightVeryRelaxed = 1.5;
const double lineHeightLooseText = 1.6;

// ============================================
// FUNCIONES HELPER PARA TAMAÑOS DE FUENTE
// ============================================
double getFontSizeSmall(double screenWidth) => screenWidth < 360 ? 10 : 12;
double getFontSizeBodySmall(double screenWidth) => screenWidth < 360 ? 12 : 13;
double getFontSizeBodyMedium(double screenWidth) => screenWidth < 360 ? 13 : 14;
double getFontSizeBody(double screenWidth) => screenWidth < 360 ? 14 : 15;
double getFontSizeBodyLarge(double screenWidth) => screenWidth < 360 ? 15 : 16;
double getFontSizeBodyXLarge(double screenWidth) => screenWidth < 360 ? 16 : 18;
double getFontSizeHeadingSmall(double screenWidth) =>
    screenWidth < 360 ? 18 : 20;
double getFontSizeHeadingMedium(double screenWidth) =>
    screenWidth < 360 ? 20 : 24;
double getFontSizeHeadingLarge(double screenWidth) =>
    screenWidth < 360 ? 24 : 28;
double getFontSizeHeadingXLarge(double screenWidth) =>
    screenWidth < 360 ? 28 : 32;
double getFontSizeHeroSmall(double screenWidth) => screenWidth < 360 ? 42 : 56;
double getFontSizeHeroLarge(double screenWidth) => screenWidth < 360 ? 56 : 72;

// ============================================
// FUNCIONES HELPER PARA ESTILOS DE TEXTO COMUNES
// ============================================

// Estilo para texto de ubicación (subtítulo)
TextStyle getLocationTextStyle(double screenWidth) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: grisMedio,
    fontSize: getFontSizeBodyLarge(screenWidth),
    fontWeight: fontWeightRegular,
    letterSpacing: letterSpacingNormal,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de cuerpo pequeño
TextStyle getBodySmallTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeBodySmall(screenWidth),
    fontWeight: fontWeightRegular,
    height: lineHeightRelaxed,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de cuerpo normal
TextStyle getBodyTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeBody(screenWidth),
    fontWeight: fontWeightRegular,
    height: lineHeightVeryRelaxed,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de cuerpo grande
TextStyle getBodyLargeTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeBodyXLarge(screenWidth),
    fontWeight: fontWeightRegular,
    height: lineHeightVeryRelaxed,
    decoration: TextDecoration.none,
  );
}

// Estilo para títulos de secciones
TextStyle getSectionTitleStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeHeadingXLarge(screenWidth),
    fontWeight: fontWeightBold,
    letterSpacing: letterSpacingMedium,
    height: lineHeightNormal,
    decoration: TextDecoration.none,
  );
}

// Estilo para subtítulos de cards
TextStyle getCardSubtitleStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? grisMedio,
    fontSize: getFontSizeBodyLarge(screenWidth),
    fontWeight: fontWeightRegular,
    letterSpacing: letterSpacingNone,
    height: lineHeightRelaxed,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de card title
TextStyle getCardTitleStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    fontSize: getFontSizeHeadingMedium(screenWidth),
    fontWeight: fontWeightSemiBold,
    letterSpacing: letterSpacingMedium,
    color: color ?? blanco,
    height: lineHeightLoose,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto bold pequeño
TextStyle getBoldSmallTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeBodyMedium(screenWidth),
    fontWeight: fontWeightBold,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto label/bold
TextStyle getLabelTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? colorWithOpacity(blanco, 0.8),
    fontSize: getFontSizeBodyMedium(screenWidth),
    fontWeight: fontWeightBold,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de card content
TextStyle getCardContentStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeHeadingSmall(screenWidth),
    fontWeight: fontWeightBold,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto destacado/hero
TextStyle getHeroTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeHeroLarge(screenWidth),
    fontWeight: fontWeightBlack,
    letterSpacing: letterSpacingTight,
    height: lineHeightTight,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto hero pequeño
TextStyle getHeroSmallTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? blanco,
    fontSize: getFontSizeHeadingMedium(screenWidth),
    fontWeight: fontWeightSemiBold,
    letterSpacing: letterSpacingLoose,
    height: lineHeightLoose,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de información (info text)
TextStyle getInfoTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    fontFamily: kFontFamily,
    color: color ?? colorWithOpacity(blanco, 0.8),
    fontSize: getFontSizeBodyMedium(screenWidth),
    height: lineHeightRelaxed,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de cita bíblica
TextStyle getBiblicalQuoteStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    color: color ?? blanco,
    fontSize: getFontSizeBody(screenWidth),
    fontStyle: FontStyle.italic,
    height: lineHeightRelaxed,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto de referencia bíblica
TextStyle getBiblicalReferenceStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    color: color ?? colorWithOpacity(blanco, 0.8),
    fontSize: getFontSizeBodyMedium(screenWidth),
    fontWeight: fontWeightBold,
    decoration: TextDecoration.none,
  );
}

// Estilo para texto monospace (números de cuenta)
TextStyle getMonospaceTextStyle(double screenWidth, {Color? color}) {
  return TextStyle(
    color: color ?? colorWithOpacity(blanco, 0.9),
    fontSize: getFontSizeBodyMedium(screenWidth),
    fontFamily: 'monospace',
    decoration: TextDecoration.none,
  );
}

// ============================================
// CONSTANTES DE ESPACIADO (Height Multipliers)
// ============================================
const double spacingXXS = 0.005;
const double spacingXS = 0.01;
const double spacingS = 0.015;
const double spacingSM = 0.02;
const double spacingM = 0.03;
const double spacingML = 0.04;
const double spacingL = 0.06;
const double spacingXL = 0.08;

// ============================================
// CONSTANTES DE ESPACIADO (Width Multipliers)
// ============================================
const double widthSpacingXS = 0.01;
const double widthSpacingS = 0.02;
const double widthSpacingM = 0.03;
const double widthSpacingML = 0.04;
const double widthSpacingL = 0.05;
const double widthSpacingXL = 0.06;
