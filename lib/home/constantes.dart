import 'package:flutter/material.dart';

const Color negro = Color.fromARGB(255, 0, 0, 0);
const Color gris = Color.fromARGB(255, 44, 49, 51);
const Color blanco = Color.fromARGB(255, 255, 255, 255);
const Color barr = Color.fromARGB(64, 255, 255, 255);
const Decorations = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      gris,
      negro,
    ],
  ),
);
const thema = TextStyle(
  color: blanco,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
const titulo = TextStyle(
  fontSize: 35,
  height: 0,
  color: blanco,
);
final double horizontalPadding = 40;
final double verticalPadding = 25;

const double defpaultPadding = 16.0;
const Duration duracion = Duration(milliseconds: 300);
