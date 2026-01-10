import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../home/constantes.dart';
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
  final double _churchLat = 15.5000;
  final double _churchLng = -88.0300;

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
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
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
    switch (app) {
      case 'google':
        url =
            "https://www.google.com/maps/search/?api=1&query=$_churchLat,$_churchLng";
        break;
      case 'apple':
        url = "http://maps.apple.com/?q=$_churchLat,$_churchLng";
        break;
      case 'waze':
        url = "https://waze.com/ul?ll=$_churchLat,$_churchLng&navigate=yes";
        break;
      default:
        return;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
          "San Pedro Sula",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: grisMedio,
            fontSize: screenWidth < 360 ? 15 : 17,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.41,
          ),
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
                color: const Color(0xFFF5F5DC),
                size: screenWidth * 0.06,
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
            "Centro Cristiano Internacional\nSan Pedro Sula, Honduras",
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: colorWithOpacity(blanco, 0.8),
              fontSize: screenWidth < 360 ? 14 : 16,
              height: 1.4,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Abrir en:",
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: blanco,
              fontSize: screenWidth < 360 ? 14 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Row(
            children: [
              _buildMapButton(
                  "Google Maps", Icons.map, Colors.blue, screenWidth),
              SizedBox(width: screenWidth * 0.03),
              _buildMapButton(
                  "Apple Maps", Icons.navigation, Colors.grey, screenWidth),
              SizedBox(width: screenWidth * 0.03),
              _buildMapButton(
                  "Waze", Icons.directions_car, Colors.purple, screenWidth),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton(
      String label, IconData icon, Color color, double screenWidth) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _openInMaps(label.toLowerCase().replaceAll(' ', '')),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
          decoration: BoxDecoration(
            color: colorWithOpacity(color, 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 1),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: screenWidth * 0.05),
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
                        style: TextStyle(
                          color: blanco,
                          fontSize: screenWidth < 360 ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                if (_isLoadingWeather)
                  CircularProgressIndicator(
                    color: const Color(0xFFF5F5DC),
                    strokeWidth: 2,
                  )
                else ...[
                  Text(
                    _temperature,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: blanco,
                      fontSize: screenWidth < 360 ? 24 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _weatherCondition,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: colorWithOpacity(blanco, 0.8),
                      fontSize: screenWidth < 360 ? 12 : 14,
                    ),
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
                      color: const Color(0xFFF5F5DC),
                      size: screenWidth * 0.06,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        "Hora Local",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: blanco,
                          fontSize: screenWidth < 360 ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                child: Text(
                  "Próxima Celebración",
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
            style: TextStyle(
              color: blanco,
              fontSize: screenWidth < 360 ? 16 : 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: colorWithOpacity(const Color(0xFFF5F5DC), 0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFFF5F5DC),
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
                  style: TextStyle(
                    color: const Color(0xFFF5F5DC),
                    fontSize: screenWidth < 360 ? 20 : 24,
                    fontWeight: FontWeight.bold,
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
