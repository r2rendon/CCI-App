import 'package:flutter/material.dart';
import 'dart:ui';
import '../utils/constants.dart';
import '../widgets/swipe_back_wrapper.dart';
import 'red_cci.dart';

class Iglesia extends StatelessWidget {
  const Iglesia({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SwipeBackWrapper(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: getGradientBackground(),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getHorizontalPadding(screenWidth),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  _buildHeader(screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildLocation(screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  _buildIntroText(screenWidth),
                  _buildVisionMisionSection(screenWidth),
                  _buildPastoresSection(screenWidth, screenHeight),
                  _buildRedCCISection(context, screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Text(
      "Seamos Iglesia",
      style: getTitulo(screenWidth),
    );
  }

  Widget _buildLocation(double screenWidth) {
    return Text(
      "San Pedro Sula",
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        color: grisMedio,
        fontSize: screenWidth < 360 ? 15 : 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.41,
      ),
    );
  }

  Widget _buildIntroText(double screenWidth) {
    return Text(
      "Ser comunidad es fundamental para crecer juntos y fortalecernos. "
      "Cuando nos unimos como comunidad, podemos compartir nuestras experiencias, "
      "conocimientos y habilidades, lo que nos permite aprender unos de otros y crecer juntos.",
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: screenWidth < 360 ? 15 : 17,
        height: 1.6,
        color: grisMedio,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
      ),
    );
  }

  Widget _buildVisionMisionSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _MisionSection(),
        _VisionSection(),
      ],
    );
  }

  Widget _buildPastoresSection(double screenWidth, double screenHeight) {
    return Builder(
      builder: (context) => Column(
        children: [
          SizedBox(height: screenHeight * 0.04),
          Text(
            "Pastores",
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              color: blanco,
              fontSize: screenWidth < 360 ? 20 : 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Container(
            height: screenHeight * 0.18,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                _PastorImage("mario", context, screenWidth, screenHeight),
                _PastorImage("karla", context, screenWidth, screenHeight),
                _PastorImage("juanramon", context, screenWidth, screenHeight),
                _PastorImage("rosa", context, screenWidth, screenHeight),
                _PastorImage("juanca", context, screenWidth, screenHeight),
                _PastorImage("kensy", context, screenWidth, screenHeight),
                _PastorImage("alejandro", context, screenWidth, screenHeight),
                _PastorImage("gaby", context, screenWidth, screenHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedCCISection(
      BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.04),
        Text(
          "Red CCI",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _navigateToRedCCI(context),
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.05),
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
                      Icons.language_outlined,
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
                          "Conoce más sobre la Red CCI",
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: blanco,
                            fontSize: screenWidth < 360 ? 16 : 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.41,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.006),
                        Text(
                          "Somos parte de una red internacional",
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: grisMedio,
                            fontSize: screenWidth < 360 ? 13 : 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.24,
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
        ),
      ],
    );
  }

  void _navigateToRedCCI(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const RedCCI(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final blurValue = (1 - animation.value) * 15.0;

          return Stack(
            children: [
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

class _MisionSection extends StatelessWidget {
  const _MisionSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.04),
        Text(
          "Misión",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          "Formar discípulos de Cristo comprometidos con la restauración integral de las familias en el mundo.",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: grisMedio,
            fontSize: screenWidth < 360 ? 15 : 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.0,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _VisionSection extends StatelessWidget {
  const _VisionSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Visión",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          "Ser una iglesia comprometida con la transformación de vidas, que refleja el evangelio de Jesús en nuestra comunidad, la nación y el mundo. ",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: grisMedio,
            fontSize: screenWidth < 360 ? 15 : 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.0,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _PastorImage extends StatelessWidget {
  final String name;
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;

  const _PastorImage(
      this.name, this.context, this.screenWidth, this.screenHeight);

  static final Map<String, Map<String, String>> _pastorInfo = {
    "mario": {
      "nombre": "Mario Valencia",
      "titulo": "Pastor General",
    },
    "karla": {
      "nombre": "Karla de Valencia",
      "titulo": "Pastora General",
    },
    "juanramon": {
      "nombre": "Juan Ramón Tábora",
      "titulo": "Pastor titular 9:00 A.M.",
    },
    "rosa": {
      "nombre": "Rosa de Tábora",
      "titulo": "Pastora titular 9:00 A.M.",
    },
    "juanca": {
      "nombre": "Juan Carlos Vallecillo",
      "titulo": "Pastor titular 11:30 A.M.",
    },
    "kensy": {
      "nombre": "Kensy de Vallecillo",
      "titulo": "Pastora titular 11:30 A.M.",
    },
    "alejandro": {
      "nombre": "Alejandro Henríquez",
      "titulo": "Pastor null",
    },
    "gaby": {
      "nombre": "Gaby de Henríquez",
      "titulo": "Pastora null",
    },
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPastorInfo(context, name),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: screenHeight * 0.13,
        height: screenHeight * 0.13,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorWithOpacity(blanco, 0.1),
          border: Border.all(color: colorWithOpacity(blanco, 0.2)),
        ),
        child: ClipOval(
          child: Image.asset(
            "assets/images/$name.png",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.person,
                size: screenHeight * 0.08,
                color: colorWithOpacity(blanco, 0.5),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showPastorInfo(BuildContext context, String name) {
    final info = _pastorInfo[name];
    if (info == null) return;

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => _PastorInfoDialog(
        nombre: info["nombre"]!,
        titulo: info["titulo"]!,
        imagePath: "assets/images/$name.png",
      ),
    );
  }
}

class _PastorInfoDialog extends StatelessWidget {
  final String nombre;
  final String titulo;
  final String imagePath;

  const _PastorInfoDialog({
    required this.nombre,
    required this.titulo,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          // Fondo con blur (glassmorphism)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
          // Contenido del modal
          Container(
            padding: EdgeInsets.all(screenWidth * 0.06),
            decoration: BoxDecoration(
              color: colorWithOpacity(grisCard, 0.9),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: colorWithOpacity(blanco, 0.2),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botón de cerrar
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: blanco),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Imagen del pastor
                Container(
                  width: screenHeight * 0.15,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorWithOpacity(blanco, 0.1),
                    border: Border.all(
                      color: colorWithOpacity(blanco, 0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: screenHeight * 0.1,
                          color: colorWithOpacity(blanco, 0.5),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Nombre
                Text(
                  nombre,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: blanco,
                    fontSize: screenWidth < 360 ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                // Título
                Text(
                  titulo,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: grisMedio,
                    fontSize: screenWidth < 360 ? 16 : 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.0,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
