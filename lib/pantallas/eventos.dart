// Eventos general: pantalla principal de eventos (AWS + notificaciones locales/push).
// Otras pantallas (Next, Alive, Shift) tienen su propia sección "Información" con eventos por categoría.
import 'package:flutter/material.dart';
import '../Informacion/actividades_externas.dart';
import '../utils/constants.dart';
import '../widgets/swipe_back_wrapper.dart';
import '../utils/aws_events_service.dart';
import '../utils/fcm_service.dart';
import '../models/event_model.dart';
import '../widgets/event_card.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  List<EventModel> _events = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _eventKeys = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final events = await AWSEventsService.getEventsGeneral();
      if (mounted) {
        setState(() {
          _events = events;
          _isLoading = false;
        });
        _tryScrollToPendingEvent();
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

  void _tryScrollToPendingEvent() {
    final pending = FCMService.consumePendingEventNavigation();
    if (pending == null || (pending['category'] ?? 'general') != 'general') return;
    final eventId = pending['eventId'];
    if (eventId == null || eventId.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final key = _eventKeys[eventId];
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      }
    });
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
              controller: _scrollController,
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
          ..._events.map((event) {
                _eventKeys[event.eventId] ??= GlobalKey();
                return Padding(
                  key: _eventKeys[event.eventId],
                  padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                  child: EventCard(
                    event: event,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                );
              }),
        SizedBox(height: screenHeight * 0.03),
        // Actividades Externas
        _buildExternalActivitiesCard(screenWidth, screenHeight),
      ],
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
