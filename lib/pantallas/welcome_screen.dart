import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import '../navigation/main_navigation.dart';
import '../home/constantes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: duracionLarga,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: curvaSuave),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: curvaSuave),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: getGradientBackground(),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: getHorizontalPadding(screenWidth),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      // Logo con texto y Hero para transición 3D
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Material(
                            color: Colors.transparent,
                            child: Hero(
                              tag: 'app_logo',
                              flightShuttleBuilder: (
                                BuildContext flightContext,
                                Animation<double> animation,
                                HeroFlightDirection flightDirection,
                                BuildContext fromHeroContext,
                                BuildContext toHeroContext,
                              ) {
                                final Hero toHero =
                                    toHeroContext.widget as Hero;
                                // Transición suave del logo con escala y opacidad
                                return AnimatedBuilder(
                                  animation: animation,
                                  builder: (context, child) {
                                    final progress = animation.value;
                                    // Escala que cambia durante la transición (de grande a pequeño)
                                    final scale = 1.0 -
                                        (progress *
                                            0.875); // De 1.0 a 0.125 (40/320 aprox)
                                    // Opacidad que se ajusta durante la transición
                                    final opacity = 1.0 - (progress * 0.2);

                                    return Opacity(
                                      opacity: opacity.clamp(0.0, 1.0),
                                      child: Transform.scale(
                                        scale: scale.clamp(0.125, 1.0),
                                        child: toHero.child,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: screenWidth * 0.5,
                                height: screenWidth * 0.5,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.church,
                                    size: screenWidth * 0.4,
                                    color: blanco,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.06),
                      // Título con animación
                      SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            Text(
                              "San Pedro",
                              style: getTitulo(screenWidth),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Sula",
                              style: getTitulo(screenWidth),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      // Subtítulo
                      SlideTransition(
                        position: _slideAnimation,
                        child: Text(
                          "Bienvenido a CCI Móvil",
                          style: getSubtitulo(screenWidth).copyWith(
                            color: grisMedio,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(flex: 2),
                      // Botón minimalista
                      SlideTransition(
                        position: _slideAnimation,
                        child: _buildStartButton(
                            context, screenWidth, screenHeight),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton(
      BuildContext context, double screenWidth, double screenHeight) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duracionLarga,
      curve: const Interval(0.5, 1.0, curve: curvaSuave),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: GestureDetector(
              onTap: () {
                // Transición con efecto blur
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MainNavigation(),
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
                                  color: Colors.black
                                      .withOpacity(0.3 * (1 - animation.value)),
                                ),
                              ),
                            ),
                          // Nueva pantalla con fade y slide
                          FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 0.03),
                                end: Offset.zero,
                              ).animate(
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
                    transitionDuration: duracionLarga,
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: blanco,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Center(
                  child: Text(
                    "Empezar",
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: screenWidth < 360 ? 16 : 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41,
                      color: negro,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
