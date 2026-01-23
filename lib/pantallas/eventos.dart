import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Informacion/actividades_externas.dart';
import '../utils/constants.dart';
import '../widgets/swipe_back_wrapper.dart';
import '../utils/aws_events_service.dart';
import '../models/event_model.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  List<EventModel> _events = [];
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
      final events = await AWSEventsService.getEvents();
      if (mounted) {
        setState(() {
          _events = events;
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

  Future<void> _refreshEvents() async {
    await _loadData();
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            IconButton(
              icon: const Icon(Icons.refresh, color: blanco),
              onPressed: _refreshEvents,
              tooltip: 'Actualizar eventos',
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.04),
        if (_events.isEmpty && !_isLoading)
          Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                children: [
                  Icon(
                    Icons.event_busy_outlined,
                    color: grisMedio,
                    size: 64,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'No hay eventos próximos',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: grisMedio,
                      fontSize: screenWidth < 360 ? 16 : 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ..._events.map((event) => Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: _buildEventCardFromModel(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  event: event,
                ),
              )),
        SizedBox(height: screenHeight * 0.03),
        // Actividades Externas
        _buildExternalActivitiesCard(screenWidth, screenHeight),
      ],
    );
  }

  Widget _buildEventCardFromModel({
    required double screenWidth,
    required double screenHeight,
    required EventModel event,
  }) {
    return _buildEventCard(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      title: event.name,
      description: event.description,
      location: event.location,
      details: event.formattedDate,
      imageUrl: event.imageUrl,
      registrationLink: event.registrationLink,
    );
  }

  Widget _buildEventCard({
    required double screenWidth,
    required double screenHeight,
    required String title,
    required String description,
    required String location,
    required String details,
    String? imageUrl,
    String? registrationLink,
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
          // Event Image
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
            child: imageUrl != null && imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.event_outlined,
                            color: grisMedio,
                            size: 48,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: accent,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                : Center(
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
                if (registrationLink != null && registrationLink.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse(registrationLink);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenWidth * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.link,
                            color: blanco,
                            size: 18,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Inscripción',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              color: blanco,
                              fontSize: screenWidth < 360 ? 14 : 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
