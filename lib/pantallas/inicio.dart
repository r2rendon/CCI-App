import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../home/home.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    print('Inicio: initState');
    _initializeAnimations();
    _startNavigationTimer();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: duracionLarga,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  void _startNavigationTimer() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !_isNavigating) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (mounted && !_isNavigating) {
      setState(() {
        _isNavigating = true;
      });
      print('Inicio: Navegando a Home');
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: duracion,
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Inicio: build');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: decorations,
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.3,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: screenWidth * 0.4,
                                height: screenWidth * 0.4,
                                decoration: BoxDecoration(
                                  color: blanco.withValues(alpha: 0.1),
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.2),
                                ),
                                child: Icon(
                                  Icons.church,
                                  size: screenWidth * 0.2,
                                  color: blanco,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Bienvenido a CCI',
                          style: getTitulo(screenWidth),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'San Pedro Sula',
                          style: TextStyle(
                            color: grisClaro,
                            fontSize: screenWidth < 360 ? 16 : 18,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.1),
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: blanco,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
