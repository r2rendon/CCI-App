import 'package:flutter/material.dart';
import 'dart:ui';
import '../pantallas/inicio.dart';
import '../pantallas/eventos.dart';
import '../pantallas/iglesia.dart';
import '../pantallas/ministerios.dart';
import '../pantallas/transmisiones.dart';
import '../pantallas/ofrendas.dart';
import '../pantallas/next.dart';
import '../pantallas/welcome_screen.dart';
import '../pantallas/ubicacion.dart';
import '../utils/constants.dart';
import '../utils/fcm_service.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();

  // Método estático para navegación desde notificaciones
  static void navigateToPage(int index) {
    _MainNavigationState._instance?._navigateToPage(index);
  }
}

class _MainNavigationState extends State<MainNavigation> {
  late PageController _pageController;
  int _currentIndex = 0;
  double _dragDeltaX = 0.0;
  bool _isVerticalScroll = false;

  final List<Widget> _screens = [
    const Inicio(),
    const Eventos(),
    const Iglesia(),
    const Ministerios(),
    const Transmisiones(),
    const Ofrendas(),
    const Ubicacion(),
    const Next(),
  ];

  // Instancia estática para acceso desde notificaciones
  static _MainNavigationState? _instance;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _instance = this;
    
    // Notificar a FCMService que MainNavigation está listo para manejar navegación pendiente
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FCMService().onMainNavigationReady();
    });
  }

  @override
  void dispose() {
    if (_instance == this) {
      _instance = null;
    }
    _pageController.dispose();
    super.dispose();
  }


  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToPage(int index) {
    if (index != _currentIndex) {
      _pageController.animateToPage(
        index,
        duration: duracionLarga,
        curve: curvaSuave,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: getGradientBackground(),
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            _dragDeltaX = 0.0;
            _isVerticalScroll = false;
            // Solo procesar si el gesto empieza desde el borde izquierdo (primeros 60px)
            if (details.globalPosition.dx > 60) {
              _isVerticalScroll =
                  true; // Ignorar gestos que no empiezan desde la izquierda
            }
          },
          onHorizontalDragUpdate: (details) {
            if (_isVerticalScroll)
              return; // Ignorar si no empezó desde la izquierda

            // Acumular solo si el movimiento es principalmente horizontal
            final absDx = details.delta.dx.abs();
            final absDy = details.delta.dy.abs();

            if (absDx > absDy) {
              // Movimiento principalmente horizontal
              _dragDeltaX += details.delta.dx;
            } else {
              // Movimiento principalmente vertical, ignorar este gesto
              _isVerticalScroll = true;
            }
          },
          onHorizontalDragEnd: (details) {
            if (_isVerticalScroll) {
              _dragDeltaX = 0.0;
              _isVerticalScroll = false;
              return;
            }

            // Solo procesar si fue un movimiento desde la izquierda hacia la derecha
            // _dragDeltaX positivo = deslizar desde izquierda hacia la derecha (retroceder)
            if (_dragDeltaX > 100) {
              // Deslizamiento desde la izquierda hacia la derecha (retroceder)
              if (_currentIndex > 0) {
                _navigateToPage(_currentIndex - 1);
              } else {
                // Si está en la primera pantalla, ir a welcome screen
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
                          // Nueva pantalla con fade y slide
                          FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(-0.03, 0.0),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: curvaSuave,
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
              }
            }
            // Resetear valores
            _dragDeltaX = 0.0;
            _isVerticalScroll = false;
          },
          behavior: HitTestBehavior.translucent,
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics:
                const NeverScrollableScrollPhysics(), // Deshabilita el scroll del PageView
            children: _screens.map((screen) {
              return PageTransitionWrapper(
                child: screen,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

}

class PageTransitionWrapper extends StatelessWidget {
  final Widget child;

  const PageTransitionWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
