import 'package:flutter/material.dart';
import 'dart:ui';
import '../utils/constants.dart';
import '../widgets/swipe_back_wrapper.dart';
import 'eventos.dart';
import 'iglesia.dart';
import 'ministerios.dart';
import 'transmisiones.dart';
import 'ofrendas.dart';
import 'youth.dart';
import 'ubicacion.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with TickerProviderStateMixin {
  late AnimationController _heroAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _logoPositionController;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _logoPositionAnimation;
  late Animation<Offset> _textPositionAnimation;
  late Animation<double> _logoPositionScaleAnimation;

  @override
  void initState() {
    super.initState();
    _heroAnimationController = AnimationController(
      duration: duracionLarga,
      vsync: this,
    );

    // Animación para el texto con efecto desde la izquierda
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Opacidad del texto (efecto wipe de izquierda a derecha)
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Animación para mover el logo y texto a su posición final
    _logoPositionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Animación de posición del logo: desde el centro hacia la derecha
    _logoPositionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0), // Posición inicial centrada
      end: const Offset(1.25, 0.0), // Posición final: a la derecha
    ).animate(
      CurvedAnimation(
        parent: _logoPositionController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Animación de posición del texto: desde el centro hacia la izquierda
    _textPositionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0), // Posición inicial centrada
      end:
          const Offset(-0.65, 0.0), // Posición final: a la izquierda (ajustado)
    ).animate(
      CurvedAnimation(
        parent: _logoPositionController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Escala del logo y texto durante la transición (se hace más pequeño)
    _logoPositionScaleAnimation = Tween<double>(
      begin: 1.0, // Tamaño inicial (centrado)
      end: 0.85, // Tamaño final (un poco más pequeño)
    ).animate(
      CurvedAnimation(
        parent: _logoPositionController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Delay para que la transición Hero se complete primero
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        // El logo ya está en posición centrada después del Hero
        _heroAnimationController.forward();
        // Iniciar animación del texto inmediatamente (aparece centrado)
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            _textAnimationController.forward();
            // Después de 0.5s, mover todo desde el centro hacia la izquierda
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                _logoPositionController.forward();
              }
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _textAnimationController.dispose();
    _logoPositionController.dispose();
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
                // Logo y texto - Inicialmente centrados, luego se separan
                ScaleTransition(
                  scale: _logoPositionScaleAnimation,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Texto que se mueve a la izquierda con efecto wipe
                        SlideTransition(
                          position: _textPositionAnimation,
                          child: Padding(
                            padding: EdgeInsets.only(top: screenWidth * 0.02),
                            child: AnimatedBuilder(
                              animation: _textOpacityAnimation,
                              builder: (context, child) {
                                return ClipRect(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: _textOpacityAnimation.value,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          kChurchName,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontFamily: kFontFamily,
                                            color: blanco,
                                            fontSize: getFontSizeBodySmall(
                                                screenWidth),
                                            fontWeight: fontWeightBold,
                                            letterSpacing: letterSpacingWider,
                                            height: lineHeightLoose,
                                          ),
                                        ),
                                        Text(
                                          kChurchSubtitle,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontFamily: kFontFamily,
                                            color: blanco,
                                            fontSize: getFontSizeBodySmall(
                                                screenWidth),
                                            fontWeight: fontWeightBold,
                                            letterSpacing: letterSpacingWider,
                                            height: lineHeightNormal,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                screenWidth * widthSpacingXS),
                                        Text(
                                          kChurchCity,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontFamily: kFontFamily,
                                            color: grisMedio,
                                            fontSize:
                                                getFontSizeSmall(screenWidth),
                                            fontWeight: fontWeightRegular,
                                            letterSpacing: letterSpacingWide,
                                            height: lineHeightLoose,
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
                        SizedBox(width: screenWidth * 0.04),
                        // Logo que se mueve a la derecha
                        SlideTransition(
                          position: _logoPositionAnimation,
                          child: Hero(
                            tag: 'app_logo',
                            child: Image.asset(
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
                          ),
                        ),
                      ],
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
                kMainMessageLine1,
                style: getHeroSmallTextStyle(screenWidth),
              ),
              SizedBox(height: screenHeight * spacingS),
              // EL AMOR - fuente mucho más grande y negrita
              Text(
                kMainMessageLine2,
                style: getHeroTextStyle(screenWidth),
              ),
              SizedBox(height: screenHeight * spacingXXS),
              // DE DIOS - fuente mucho más grande y negrita
              Text(
                kMainMessageLine3,
                style: getHeroTextStyle(screenWidth),
              ),
              SizedBox(height: screenHeight * spacingS),
              // PARA QUE EL MUNDO CREA - fuente más pequeña
              Text(
                kMainMessageLine4,
                style: getHeroSmallTextStyle(screenWidth),
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
        'title': 'Youth',
        'subtitle': 'Próximas generaciones',
        'screen': const Youth(),
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
          kSectionExplore,
          style: getSectionTitleStyle(screenWidth),
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
                      style: getCardTitleStyle(screenWidth),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    Text(
                      subtitle,
                      style: getCardSubtitleStyle(screenWidth),
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
                      color: Colors.black.withValues(
                          alpha: (0.3 * (1 - animation.value)).clamp(0.0, 1.0)),
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
