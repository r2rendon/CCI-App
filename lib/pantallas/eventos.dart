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
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _loadData,
              color: blanco,
              backgroundColor: negro,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  decoration: decorations,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      _buildHeader(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.02),
                      _buildLocation(screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildWelcomeMessage(screenWidth),
                      _buildSeriesSection(screenWidth, screenHeight),
                      _buildEventsSection(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),
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
              "Eventos del mes",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/logo.png",
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
      child: Text(
        "Hola! Tú eres parte de la gran familia de CCI San Pedro Sula, y por esto queremos que estés enterado de todo lo que se viene! "
        "Aquí encontrarás los próximos eventos para que puedas agendar las fechas y no te pierdas de nada.",
        style: TextStyle(
          height: 1.5,
          fontSize: screenWidth < 360 ? 16 : 18,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildSeriesSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _serieTitle.toUpperCase(),
            style: TextStyle(
              fontSize: screenWidth < 360 ? 20 : 23,
              fontWeight: FontWeight.bold,
              color: blanco,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: double.infinity,
            height: screenHeight * 0.2,
            child: Image.network(
              _serieImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  color: colorWithOpacity(gris, 0.3),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: colorWithOpacity(blanco, 0.2)),
                ),
                child: Image.asset(
                  "assets/images/Serie.png",
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image,
                      size: screenHeight * 0.1,
                      color: colorWithOpacity(blanco, 0.5),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildSeriesContent(screenWidth),
          Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildSeriesContent(double screenWidth) {
    final themes = _serieThemes.split(',');
    return Column(
      children: [
        Center(
          child: Text(
            "Serie del Mes",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth < 360 ? 16 : 18,
              color: blanco,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        ...themes
            .map((theme) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    theme.trim(),
                    style: TextStyle(
                      color: barr,
                      fontSize: screenWidth < 360 ? 14 : 16,
                    ),
                  ),
                ))
            .toList(),
        SizedBox(height: screenWidth * 0.05),
      ],
    );
  }

  Widget _buildEventsSection(double screenWidth, double screenHeight) {
    final events = _monthlyEvents.split('|');
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "EVENTOS DE ABRIL",
            style: TextStyle(
              fontSize: screenWidth < 360 ? 20 : 23,
              fontWeight: FontWeight.bold,
              color: blanco,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          ...events.asMap().entries.map((entry) {
            final eventData = entry.value.split(',');
            if (eventData.length >= 3) {
              return _buildEventCard(
                eventData[0].trim(),
                eventData[1].trim(),
                eventData[2].trim(),
                entry.key % 2 == 0,
                screenWidth,
                screenHeight,
                showMap: eventData.length > 3 && eventData[3].trim() == 'true',
              );
            }
            return const SizedBox.shrink();
          }).toList(),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String date, String location,
      bool isRight, double screenWidth, double screenHeight,
      {bool showMap = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: isRight ? screenWidth * 0.25 : 0,
        right: isRight ? 0 : screenWidth * 0.25,
        bottom: screenHeight * 0.02,
      ),
      child: Card(
        elevation: 2,
        color: const Color.fromARGB(20, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth < 360 ? 16 : 18,
                  color: blanco,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                date,
                style: TextStyle(
                  color: blanco,
                  fontWeight: FontWeight.w300,
                  fontSize: screenWidth < 360 ? 14 : 16,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                location,
                style: TextStyle(
                  color: blanco,
                  fontWeight: FontWeight.w300,
                  fontSize: screenWidth < 360 ? 14 : 16,
                ),
                textAlign: TextAlign.center,
              ),
              if (showMap)
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01),
                  child: const Externa('mapa'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
