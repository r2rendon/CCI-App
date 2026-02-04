import 'package:flutter/material.dart';
import 'dart:ui';
import '../pantallas/welcome_screen.dart';
import '../navigation/main_navigation.dart';
import '../utils/fcm_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    print('SplashScreen: initState');

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Animación de escala simple: aparece desde pequeño
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      await FCMService().ensureInitialMessage();
      if (!mounted) return;
      final openFromNotification = FCMService.hasPendingNotification;
      if (openFromNotification) {
          print('SplashScreen: Abierto desde notificación, yendo a MainNavigation');
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainNavigation(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        } else {
          print('SplashScreen: Navegando a WelcomeScreen');
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const WelcomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Efecto blur progresivo
              final blurValue = (1 - animation.value) * 15.0;
              
              return Stack(
                children: [
                  // Fondo con blur que simula la pantalla anterior borrosa
                  if (animation.value < 1.0)
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: blurValue,
                          sigmaY: blurValue,
                        ),
                        child: Container(
                          color: Colors.black.withValues(alpha: (0.3 * (1 - animation.value)).clamp(0.0, 1.0)),
                        ),
                      ),
                    ),
                  // Nueva pantalla con fade y scale
                  FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.96, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ],
              );
            },
              transitionDuration: const Duration(milliseconds: 600),
            ),
          );
        }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('SplashScreen: build');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Image.asset(
                'assets/images/Logo CCI SPS_Globo Gris Oscuro.png',
                width: screenWidth * 0.7,
                height: screenHeight * 0.4,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 120, color: Colors.red);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
