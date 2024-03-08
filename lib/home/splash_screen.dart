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
    Timer(Duration(milliseconds: (1.2 * 1000).round()), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Inicio()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.asset("assets/in.json"),
      ),
    );
  }
}
