import 'package:flutter/material.dart';
import '../Informacion/actividades_externas.dart';
import '../home/constantes.dart';
import '../widgets/swipe_back_wrapper.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  String _serieTitle = 'Serie de ejemplo';
  String _serieThemes = 'Tema 1, Tema 2, Tema 3';
  String _monthlyEvents = 'Evento 1|Evento 2|Evento 3';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorMessage('Error al cargar los eventos');
      }
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
        child: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
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
                    SizedBox(height: screenHeight * 0.04),
                    _buildLocation(screenWidth),
                    SizedBox(height: screenHeight * 0.06),
                    _buildHeroSection(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.08),
                    _buildEventsSection(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.08),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: colorWithOpacity(negro, 0.7),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: primario,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Text(
      "Eventos",
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
        letterSpacing: 0.0,
      ),
    );
  }

  Widget _buildHeroSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "EVENTOS Y ACTIVIDADES",
          overflow: TextOverflow.visible,
          style: getHeroSubtitle(screenWidth),
        ),
        SizedBox(height: screenHeight * 0.02),
        Text(
          "Mantente al día con nuestros eventos",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 17 : 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Text(
          "Descubre las próximas actividades, series especiales y eventos que tenemos preparados para ti y tu familia. Cada evento está diseñado para fortalecer nuestra comunidad y enriquecer tu experiencia espiritual.",
          overflow: TextOverflow.visible,
          style: getHeroDescription(screenWidth),
        ),
      ],
    );
  }

  Widget _buildEventsSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Próximos Eventos",
          overflow: TextOverflow.visible,
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
        // Serie Actual Card
        _buildEventCard(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          title: _serieTitle,
          description: "Una serie especial diseñada para profundizar en temas fundamentales de la fe y el crecimiento espiritual.",
          location: "San Pedro Sula",
          details: "Serie Actual",
          themes: _serieThemes,
        ),
        SizedBox(height: screenHeight * 0.03),
        // Eventos del Mes
        ..._monthlyEvents.split('|').map((event) => Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.03),
              child: _buildEventCard(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                title: event.trim(),
                description: "Únete a nosotros para este evento especial donde compartiremos momentos significativos de comunidad y crecimiento.",
                location: "San Pedro Sula",
                details: "Evento Mensual",
                themes: "",
              ),
            )),
        SizedBox(height: screenHeight * 0.03),
        // Actividades Externas
        _buildExternalActivitiesCard(screenWidth, screenHeight),
      ],
    );
  }

  Widget _buildEventCard({
    required double screenWidth,
    required double screenHeight,
    required String title,
    required String description,
    required String location,
    required String details,
    required String themes,
  }) {
    return Container(
      width: double.infinity,
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
          // Image placeholder
          Container(
            width: double.infinity,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              color: colorWithOpacity(blanco, 0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.event_outlined,
                color: grisMedio,
                size: 48,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: blanco,
                    fontSize: screenWidth < 360 ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  description,
                  overflow: TextOverflow.visible,
                  style: getHeroDescription(screenWidth),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: grisMedio,
                      size: 18,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: grisMedio,
                          fontSize: screenWidth < 360 ? 13 : 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenWidth * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: colorWithOpacity(blanco, 0.1),
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                      ),
                      child: Text(
                        details,
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: blanco,
                          fontSize: screenWidth < 360 ? 11 : 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (themes.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    "Temas: $themes",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: grisMedio,
                      fontSize: screenWidth < 360 ? 13 : 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExternalActivitiesCard(double screenWidth, double screenHeight) {
    return Container(
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
          Text(
            "Actividades Externas",
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              color: blanco,
              fontSize: screenWidth < 360 ? 20 : 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          ActividadesExternas(),
        ],
      ),
    );
  }
}
