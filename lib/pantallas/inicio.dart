import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import '../home/constantes.dart';
import '../widgets/swipe_back_wrapper.dart';
import 'eventos.dart';
import 'iglesia.dart';
import 'ministerios.dart';
import 'transmisiones.dart';
import 'ofrendas.dart';
import 'next.dart';
import 'ubicacion.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with TickerProviderStateMixin {
  late AnimationController _heroAnimationController;
  late AnimationController _logoTransitionController;
  late Animation<double> _logoScaleAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _heroAnimationController = AnimationController(
      duration: duracionLarga,
      vsync: this,
    );

    // Animación para la transición del logo desde el centro
    _logoTransitionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Animación de escala: desde grande (centro) hasta tamaño final
    _logoScaleAnimation = Tween<double>(
      begin: 1.4, // Más grande al inicio (centro)
      end: 1.0, // Tamaño final
    ).animate(
      CurvedAnimation(
        parent: _logoTransitionController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Animación de posición: desde el centro hacia la izquierda
    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.2), // Desde arriba y centrado
      end: Offset.zero, // Posición final
    ).animate(
      CurvedAnimation(
        parent: _logoTransitionController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Opacidad del logo
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoTransitionController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Opacidad del texto (aparece después)
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoTransitionController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    // Delay para que la transición Hero se complete primero
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _logoTransitionController.forward();
        _heroAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _logoTransitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SwipeBackWrapper(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: getGradientBackground(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getHorizontalPadding(screenWidth),
            ).copyWith(
              top: MediaQuery.of(context).padding.top + 0.05,
              bottom: MediaQuery.of(context).padding.bottom + 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: screenHeight * 0.01),
                // Logo grande con transición animada desde el centro
                Center(
                  child: Hero(
                    tag: 'app_logo',
                    child: FadeTransition(
                      opacity: _logoOpacityAnimation,
                      child: SlideTransition(
                        position: _logoSlideAnimation,
                        child: ScaleTransition(
                          scale: _logoScaleAnimation,
                          child: SizedBox(
                            width: screenWidth -
                                (getHorizontalPadding(screenWidth) * 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Logo grande con animación
                                Image.asset(
                                  'assets/images/Logo CCI SPS_Globo Gris Oscuro.png',
                                  width: screenWidth * 0.20,
                                  height: screenWidth * 0.20,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.church,
                                      size: screenWidth * 0.3,
                                      color: blanco,
                                    );
                                  },
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                // Texto junto al logo con animación de fade
                                Flexible(
                                  child: FadeTransition(
                                    opacity: _textOpacityAnimation,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "CENTRO CRISTIANO",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Display',
                                            color: blanco,
                                            fontSize:
                                                screenWidth < 360 ? 12 : 13,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                            height: 1.2,
                                          ),
                                        ),
                                        Text(
                                          "INTERNACIONAL",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Display',
                                            color: blanco,
                                            fontSize:
                                                screenWidth < 360 ? 12 : 13,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                            height: 1.1,
                                          ),
                                        ),
                                        SizedBox(height: screenWidth * 0.01),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: screenWidth * 0.01),
                                          child: Text(
                                            "SAN PEDRO SULA",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: 'SF Pro Display',
                                              color: grisMedio,
                                              fontSize:
                                                  screenWidth < 360 ? 9 : 10,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.3,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                _buildHeroSection(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.08),
                _buildMenuGrid(context, screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(double screenWidth, double screenHeight) {
    return FadeTransition(
      opacity: _heroAnimationController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main headline con diferentes tamaños
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MOSTREMOS - fuente más pequeña
              Text(
                "MOSTREMOS",
                style: TextStyle(
                  color: blanco,
                  fontFamily: 'SF Pro Display',
                  fontSize: screenWidth < 360 ? 20 : 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              // EL AMOR - fuente mucho más grande y negrita
              Text(
                "EL AMOR",
                style: TextStyle(
                  color: blanco,
                  fontFamily: 'SF Pro Display',
                  fontSize: screenWidth < 360 ? 56 : 72,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                  height: 0.95,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              // DE DIOS - fuente mucho más grande y negrita
              Text(
                "DE DIOS",
                style: TextStyle(
                  color: blanco,
                  fontFamily: 'SF Pro Display',
                  fontSize: screenWidth < 360 ? 56 : 72,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                  height: 0.95,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              // PARA QUE EL MUNDO CREA - fuente más pequeña
              Text(
                "PARA QUE EL MUNDO CREA",
                style: TextStyle(
                  color: blanco,
                  fontFamily: 'SF Pro Display',
                  fontSize: screenWidth < 360 ? 20 : 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          // Imagen del mundo
          Center(
            child: Image.asset(
              'assets/images/mundo.png',
              width: screenWidth - (getHorizontalPadding(screenWidth) * 2),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.public,
                  size: screenWidth * 0.3,
                  color: blanco,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(
      BuildContext context, double screenWidth, double screenHeight) {
    final menuItems = [
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'Eventos',
        'subtitle': 'Próximas actividades',
        'screen': const Eventos(),
      },
      {
        'icon': Icons.church_outlined,
        'title': 'Seamos Iglesia',
        'subtitle': 'Conoce más sobre nosotros',
        'screen': const Iglesia(),
      },
      {
        'icon': Icons.people_outline,
        'title': 'Ministerios CCI',
        'subtitle': 'Nuestros ministerios',
        'screen': const Ministerios(),
      },
      {
        'icon': Icons.live_tv_outlined,
        'title': 'En vivo',
        'subtitle': 'Transmisiones en vivo',
        'screen': const Transmisiones(),
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Dar',
        'subtitle': 'Ofrendas y donaciones',
        'screen': const Ofrendas(),
      },
      {
        'icon': Icons.arrow_forward_outlined,
        'title': 'Next',
        'subtitle': 'Próximas generaciones',
        'screen': const Next(),
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Ubicación',
        'subtitle': 'Encuéntranos y visita',
        'screen': const Ubicacion(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Explorar",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 24 : 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1.1,
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        ...menuItems.map((item) => Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: _buildLuxuryCard(
                context: context,
                icon: item['icon'] as IconData,
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
                screen: item['screen'] as Widget,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            )),
      ],
    );
  }

  Widget _buildLuxuryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget screen,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _navigateToScreen(context, screen),
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.06),
          decoration: BoxDecoration(
            color: grisCard,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: colorWithOpacity(blanco, 0.1),
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorWithOpacity(blanco, 0.1),
                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                ),
                child: Icon(
                  icon,
                  color: blanco,
                  size: 28,
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: screenWidth < 360 ? 19 : 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                        color: blanco,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: screenWidth < 360 ? 15 : 17,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.0,
                        color: grisMedio,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: grisMedio,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Efecto blur progresivo: la pantalla anterior se vuelve borrosa
          final blurValue =
              (1 - animation.value) * 15.0; // De 15 (muy borroso) a 0 (claro)

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
                      color:
                          Colors.black.withOpacity(0.3 * (1 - animation.value)),
                    ),
                  ),
                ),
              // Nueva pantalla con fade in
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
  }
}
