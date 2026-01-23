import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../widgets/swipe_back_wrapper.dart';

class RedCCI extends StatefulWidget {
  const RedCCI({super.key});

  @override
  State<RedCCI> createState() => _RedCCIState();
}

class _RedCCIState extends State<RedCCI> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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
                  _buildDescriptionSection(screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  _buildImageCarousel(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.04),
                  _buildKeyDataSection(screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  _buildLeadershipSection(screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  _buildContactSection(context, screenWidth),
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
      "Red Misionera Global CCI",
      overflow: TextOverflow.visible,
      style: getTitulo(screenWidth),
    );
  }

  Widget _buildLocation(double screenWidth) {
    return Text(
      "San Pedro Sula",
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        color: grisMedio,
        fontSize: screenWidth < 360 ? 15 : 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.41,
      ),
    );
  }

  final List<String> _images = [
    "assets/images/Mmundo.png",
    "assets/images/Africa.png",
    "assets/images/America Central y Caribe.png",
    "assets/images/America del Norte.png",
    "assets/images/America del Sur.png",
    "assets/images/Asia.png",
    "assets/images/Europa.png",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildImageCarousel(double screenWidth, double screenHeight) {
    // La imagen es 1920x1080 (relación 16:9), altura = ancho * (9/16)
    final imageHeight = screenWidth * (9 / 16);
    
    return Column(
      children: [
        SizedBox(
          height: imageHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showFullScreenImage(context, index),
                child: AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: grisCard,
                            borderRadius: BorderRadius.circular(borderRadius),
                            border: Border.all(
                              color: colorWithOpacity(blanco, 0.1),
                              width: 0.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3 * value),
                                blurRadius: 20 * (1 - value),
                                offset: Offset(0, 10 * (1 - value)),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius),
                            child: Image.asset(
                              _images[index],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    size: screenWidth * 0.2,
                                    color: grisMedio,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _images.length,
            (index) => _buildDotIndicator(index == _currentIndex),
          ),
        ),
      ],
    );
  }

  void _showFullScreenImage(BuildContext context, int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            _FullScreenImageViewer(
          images: _images,
          initialIndex: index,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildDotIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? primario : colorWithOpacity(blanco, 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildDescriptionSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Acerca de la Red Misionera Global CCI",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        Container(
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
          child: Text(
            "La Red Misionera Global CCI es la extensión misionera del Centro Cristiano Internacional (CCI). "
            "Trabaja continuamente en la edificación y fortalecimiento de las iglesias que la integran, "
            "proveyendo un ámbito organizacional de trabajo y cooperación, basado en una visión misionera compartida "
            "y en relaciones fraternas, comprometidos con la predicación del Evangelio de Jesucristo en las naciones.",
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: screenWidth < 360 ? 15 : 17,
              height: 1.6,
              color: blanco,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyDataSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Datos Clave",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildKeyDataItem(
                screenWidth,
                "Más de 500 iglesias y acciones misioneras",
              ),
              _buildKeyDataItem(
                screenWidth,
                "Presencia en 52 países",
              ),
              _buildKeyDataItem(
                screenWidth,
                "Alcance en América, Europa, Asia y África",
              ),
              _buildKeyDataItem(
                screenWidth,
                "Operaciones gestionadas desde el Centro Mundial de Operaciones CCI en Estados Unidos",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeyDataItem(double screenWidth, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenWidth * 0.015,
              right: screenWidth * 0.03,
            ),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: primario,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: screenWidth < 360 ? 14 : 16,
                height: 1.5,
                color: grisMedio,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadershipSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Liderazgo",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        Container(
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
          child: Text(
            "La Red Misionera Global CCI es dirigida por el Obispo Alberto Solórzano.",
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: screenWidth < 360 ? 15 : 17,
              height: 1.6,
              color: blanco,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contacto",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactItem(
                context,
                screenWidth,
                icon: Icons.language_outlined,
                label: "Sitio web",
                value: "www.redglobalcci.org",
                onTap: () => _launchURL("https://www.redglobalcci.org"),
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildContactItem(
                context,
                screenWidth,
                icon: Icons.email_outlined,
                label: "Correo electrónico",
                value: "redmisionera@ccihonduras.org",
                onTap: () => _launchURL("mailto:redmisionera@ccihonduras.org"),
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildContactItem(
                context,
                screenWidth,
                icon: Icons.phone_outlined,
                label: "Teléfono / WhatsApp",
                value: "+504 9905-1162",
                onTap: () => _launchURL("tel:+50499051162"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    double screenWidth, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        child: Row(
          children: [
            Icon(
              icon,
              color: primario,
              size: 24,
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: grisMedio,
                      fontSize: screenWidth < 360 ? 13 : 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.0,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: blanco,
                      fontSize: screenWidth < 360 ? 15 : 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
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
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Image.asset(
                    widget.images[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 100,
                          color: Colors.white54,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          // Botón de cerrar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    '${_currentIndex + 1} / ${widget.images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Indicadores de puntos en la parte inferior
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  width: index == _currentIndex ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index == _currentIndex
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
