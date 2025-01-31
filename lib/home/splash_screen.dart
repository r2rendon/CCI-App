import 'dart:async';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../pantallas/inicio.dart';

// Provider para manejar el estado de navegación
final splashNavigationProvider = StateProvider<bool>((ref) => false);

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(duracion, () {
      if (mounted) {
        ref.read(splashNavigationProvider.notifier).state = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios en el provider
    ref.listen(splashNavigationProvider, (previous, next) {
      if (next) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Inicio()),
        );
      }
    });

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