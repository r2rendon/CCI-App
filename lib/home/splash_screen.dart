import 'dart:async';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../pantallas/inicio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(duracion, () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Inicio(),),
        );
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: Center(
        child: Lottie.asset(
          "assets/in.json",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
