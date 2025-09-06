import 'package:flutter/material.dart';

// Colores principales
const Color negro = Color.fromARGB(255, 0, 0, 0);
const Color gris = Color.fromARGB(255, 44, 49, 51);
const Color blanco = Color.fromARGB(255, 255, 255, 255);
const Color barr = Color.fromARGB(64, 255, 255, 255);
const Color grisClaro = Color.fromARGB(255, 128, 128, 128);
const Color azulPrimario = Color.fromARGB(255, 33, 150, 243);

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

// Tipografías responsivas
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

// Padding responsivo
double getHorizontalPadding(double screenWidth) {
  if (screenWidth < 360) return 20;
  if (screenWidth < 600) return 40;
  return 60;
}

double getVerticalPadding(double screenWidth) {
  if (screenWidth < 360) return 15;
  if (screenWidth < 600) return 25;
  return 35;
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
