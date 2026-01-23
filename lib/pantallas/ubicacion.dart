import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../widgets/swipe_back_wrapper.dart';

class Ubicacion extends StatefulWidget {
  const Ubicacion({super.key});

  @override
  State<Ubicacion> createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  Timer? _timer;
  DateTime _currentTime = DateTime.now();
  String _temperature = "Cargando...";
  String _weatherCondition = "";
  bool _isLoadingWeather = true;

  // Coordenadas de la iglesia en San Pedro Sula
  final double _churchLat = 15.4993977;
  final double _churchLng = -88.0429316;
  
  // Dirección completa de la iglesia
  final String _churchAddress = kChurchAddress;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _fetchWeather();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  Future<void> _fetchWeather() async {
    try {
      // Simulamos la temperatura de San Pedro Sula (en una app real usarías una API como OpenWeatherMap)
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _temperature = "28°C";
        _weatherCondition = "Soleado";
        _isLoadingWeather = false;
      });
    } catch (e) {
      setState(() {
        _temperature = "N/A";
        _weatherCondition = "Error";
        _isLoadingWeather = false;
      });
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12;
    final hour12 = hour == 0 ? 12 : hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return "$hour12:$minute $period";
  }

  String _formatDate(DateTime time) {
    const months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    const days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];

    return "${days[time.weekday - 1]}, ${time.day} de ${months[time.month - 1]}";
  }

  Duration _getTimeToNextService() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Próximo domingo
    int daysUntilSunday = (7 - now.weekday) % 7;
    if (daysUntilSunday == 0 && now.hour >= 11 && now.minute >= 30) {
      daysUntilSunday =
          7; // Si ya pasó el último servicio, ir al siguiente domingo
    }

    final nextSunday = today.add(Duration(days: daysUntilSunday));

    // Servicios: 9:00 AM y 11:30 AM
    final service1 =
        DateTime(nextSunday.year, nextSunday.month, nextSunday.day, 9, 0);
    final service2 =
        DateTime(nextSunday.year, nextSunday.month, nextSunday.day, 11, 30);

    DateTime nextService;
    if (now.weekday == DateTime.sunday) {
      // Si es domingo, verificar cuál servicio es el próximo
      if (now.hour < 9 || (now.hour == 9 && now.minute < 0)) {
        nextService = service1;
      } else if (now.hour < 11 || (now.hour == 11 && now.minute < 30)) {
        nextService = service2;
      } else {
        nextService = service1.add(const Duration(days: 7));
      }
    } else {
      nextService = service1;
    }

    return nextService.difference(now);
  }

  String _formatCountdown(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (days > 0) {
      return "${days}d ${hours}h ${minutes}m";
    } else if (hours > 0) {
      return "${hours}h ${minutes}m ${seconds}s";
    } else {
      return "${minutes}m ${seconds}s";
    }
  }

  Future<void> _openInMaps(String app) async {
    String url;
    final encodedAddress = Uri.encodeComponent("Centro Cristiano Internacional - CCI, 21 Avenida C, San Pedro Sula 21104, Honduras");
    
    switch (app) {
      case 'google':
      case 'googlemaps':
        // Usar coordenadas exactas para mejor precisión
        url = "https://www.google.com/maps/search/?api=1&query=$_churchLat,$_churchLng";
        // Alternativa con dirección: url = "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
        break;
      case 'apple':
      case 'applemaps':
        // Apple Maps con coordenadas
        url = "https://maps.apple.com/?ll=$_churchLat,$_churchLng&q=$encodedAddress";
        break;
      case 'waze':
        // Waze con coordenadas y navegación
        url = "https://waze.com/ul?ll=$_churchLat,$_churchLng&navigate=yes";
        break;
      default:
        return;
    }

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: intentar con URL alternativa
        if (app == 'google' || app == 'googlemaps') {
          final fallbackUri = Uri.parse("https://www.google.com/maps/dir/?api=1&destination=$_churchLat,$_churchLng");
          if (await canLaunchUrl(fallbackUri)) {
            await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
          }
        }
      }
    } catch (e) {
      debugPrint('Error abriendo mapa: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final countdown = _getTimeToNextService();

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
                  // Header
                  _buildHeader(screenWidth),
                SizedBox(height: screenHeight * 0.03),

                // Location Card
                _buildLocationCard(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),

                // Weather and Time Card
                _buildWeatherTimeCard(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),

                // Countdown Card
                _buildCountdownCard(screenWidth, screenHeight, countdown),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ubicación",
          overflow: TextOverflow.visible,
          style: getTitulo(screenWidth),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          kLocationName,
          overflow: TextOverflow.visible,
          style: getLocationTextStyle(screenWidth),
        ),
      ],
    );
  }

  Widget _buildLocationCard(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: colorWithOpacity(blanco, 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorWithOpacity(blanco, 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: beigeCream,
                size: screenWidth * widthSpacingXL,
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Text(
                  "Ubicación de la Iglesia",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: blanco,
                    fontSize: screenWidth < 360 ? 18 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            _churchAddress,
            overflow: TextOverflow.visible,
            style: getInfoTextStyle(screenWidth, color: colorWithOpacity(blanco, 0.8)),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Abrir en:",
            overflow: TextOverflow.visible,
            style: getLabelTextStyle(screenWidth),
          ),
          SizedBox(height: screenHeight * 0.015),
          Row(
            children: [
              _buildMapButton(
                  "Google Maps", "assets/images/gmaps.png", Colors.blue, screenWidth),
              SizedBox(width: screenWidth * 0.03),
              _buildMapButton(
                  "Apple Maps", "assets/images/apmaps.png", Colors.grey, screenWidth),
              SizedBox(width: screenWidth * 0.03),
              _buildMapButton(
                  "Waze", "assets/images/waze.png", Colors.purple, screenWidth),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton(
      String label, String imagePath, Color color, double screenWidth) {
    String mapKey = label.toLowerCase();
    if (mapKey == 'google maps') {
      mapKey = 'googlemaps';
    } else if (mapKey == 'apple maps') {
      mapKey = 'applemaps';
    }
    
    return Expanded(
      child: GestureDetector(
        onTap: () => _openInMaps(mapKey.replaceAll(' ', '')),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
          decoration: BoxDecoration(
            color: colorWithOpacity(color, 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 1),
          ),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.map,
                    color: color,
                    size: screenWidth * 0.05,
                  );
                },
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: screenWidth < 360 ? 10 : 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherTimeCard(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: colorWithOpacity(blanco, 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorWithOpacity(blanco, 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Weather Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      color: Colors.orange,
                      size: screenWidth * 0.06,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        "Clima",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      style: getCardContentStyle(screenWidth),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                  if (_isLoadingWeather)
                  CircularProgressIndicator(
                    color: beigeCream,
                    strokeWidth: 2,
                  )
                else ...[
                  Text(
                    _temperature,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: getCardContentStyle(screenWidth, color: blanco).copyWith(
                      fontSize: getFontSizeHeadingLarge(screenWidth),
                    ),
                  ),
                  Text(
                    _weatherCondition,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: getInfoTextStyle(screenWidth),
                  ),
                ],
              ],
            ),
          ),
          // Time Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: beigeCream,
                      size: screenWidth * 0.06,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        "Hora Local",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      style: getCardContentStyle(screenWidth),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  _formatTime(_currentTime),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: blanco,
                    fontSize: screenWidth < 360 ? 24 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDate(_currentTime),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: colorWithOpacity(blanco, 0.8),
                    fontSize: screenWidth < 360 ? 12 : 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownCard(
      double screenWidth, double screenHeight, Duration countdown) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: colorWithOpacity(blanco, 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorWithOpacity(blanco, 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.church,
                color: const Color(0xFFF5F5DC),
                size: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child:                 Text(
                  "Próxima Celebración",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: getCardContentStyle(screenWidth),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Servicios Dominicales:",
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: colorWithOpacity(blanco, 0.8),
              fontSize: screenWidth < 360 ? 14 : 16,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            "9:00 AM y 11:30 AM",
            overflow: TextOverflow.visible,
            style: getLabelTextStyle(screenWidth, color: blanco).copyWith(
              fontSize: getFontSizeBodyXLarge(screenWidth),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: colorWithOpacity(beigeCream, 0.1),
              borderRadius: BorderRadius.circular(borderRadiusSmall),
              border: Border.all(
                color: beigeCream,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Tiempo restante:",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: colorWithOpacity(blanco, 0.8),
                    fontSize: screenWidth < 360 ? 12 : 14,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  _formatCountdown(countdown),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: getCardContentStyle(screenWidth, color: beigeCream).copyWith(
                    fontSize: getFontSizeHeadingMedium(screenWidth),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
