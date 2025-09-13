import 'package:flutter/material.dart';
import '../Informacion/actividades_externas.dart';
import '../home/constantes.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  String _serieTitle = 'Serie de ejemplo';
  String _serieImage = '';
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
      // Simular carga de datos
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

    return Scaffold(
      backgroundColor: negro,
      body: Container(
        decoration: decorations,
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    _buildHeader(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildLocation(screenWidth),
                    SizedBox(height: screenHeight * 0.02),
                    _buildWelcomeMessage(screenWidth),
                    _buildSerieSection(screenWidth, screenHeight),
                    _buildMonthlyEventsSection(screenWidth, screenHeight),
                    _buildExternalActivities(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
              if (_isLoading)
                Container(
                  color: colorWithOpacity(negro, 0.7),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: blanco,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getHorizontalPadding(screenWidth),
        vertical: getVerticalPadding(screenWidth),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Eventos",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/Serie.png",
            height: screenHeight * 0.05,
            color: blanco,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.event,
                size: screenHeight * 0.05,
                color: blanco,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocation(double screenWidth) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getHorizontalPadding(screenWidth)),
      child: Text(
        "San Pedro Sula",
        style: TextStyle(
          color: blanco,
          fontSize: screenWidth < 360 ? 14 : 16,
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: colorWithOpacity(azulPrimario, 0.2),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: azulPrimario),
        ),
        child: Column(
          children: [
            Icon(
              Icons.calendar_today,
              color: azulPrimario,
              size: screenWidth * 0.06,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              "¡Mantente al día con nuestros eventos!",
              style: TextStyle(
                color: blanco,
                fontSize: screenWidth < 360 ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              "Descubre las próximas actividades, series especiales y eventos "
              "que tenemos preparados para ti y tu familia.",
              style: TextStyle(
                color: blanco,
                fontSize: screenWidth < 360 ? 14 : 15,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSerieSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Text(
            "Serie Actual",
            style: getThema(screenWidth),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: colorWithOpacity(blanco, 0.1),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: colorWithOpacity(blanco, 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _serieTitle,
                  style: TextStyle(
                    color: blanco,
                    fontSize: screenWidth < 360 ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                if (_serieImage.isNotEmpty)
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.15,
                    child: Image.asset(
                      "assets/images/$_serieImage.png",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: colorWithOpacity(gris, 0.3),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          child: Icon(
                            Icons.image,
                            size: screenWidth * 0.2,
                            color: colorWithOpacity(blanco, 0.5),
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  "Temas: $_serieThemes",
                  style: TextStyle(
                    color: colorWithOpacity(blanco, 0.8),
                    fontSize: screenWidth < 360 ? 13 : 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyEventsSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Text(
            "Eventos del Mes",
            style: getThema(screenWidth),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: colorWithOpacity(blanco, 0.1),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: colorWithOpacity(blanco, 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Próximos Eventos:",
                  style: TextStyle(
                    color: blanco,
                    fontSize: screenWidth < 360 ? 15 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                ..._monthlyEvents.split('|').map((event) => Padding(
                      padding: EdgeInsets.only(bottom: screenWidth * 0.01),
                      child: Row(
                        children: [
                          Icon(
                            Icons.event_note,
                            color: azulPrimario,
                            size: screenWidth * 0.04,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Text(
                              event.trim(),
                              style: TextStyle(
                                color: blanco,
                                fontSize: screenWidth < 360 ? 13 : 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExternalActivities(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Text(
            "Actividades Externas",
            style: getThema(screenWidth),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: colorWithOpacity(blanco, 0.1),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: colorWithOpacity(blanco, 0.2)),
            ),
            child: ActividadesExternas(),
          ),
        ],
      ),
    );
  }
}
