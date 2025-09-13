import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../utils/Transmision_Live.dart';
import '../utils/Transmision_Reciente.dart';

class Transmisiones extends StatelessWidget {
  const Transmisiones({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: negro,
      body: Container(
        decoration: decorations,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                _buildHeader(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),
                _buildLocation(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildLiveStream(screenWidth, screenHeight),
                _buildWelcomeMessage(screenWidth),
                _buildRecentStream(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
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
              "En Vivo",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/transmision.png",
            height: screenHeight * 0.05,
            color: blanco,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.videocam,
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

  Widget _buildLiveStream(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              color: colorWithOpacity(negro, 0.8),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: colorWithOpacity(blanco, 0.2)),
            ),
            child: TransmisionLive(),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
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
              Icons.live_tv,
              color: azulPrimario,
              size: screenWidth * 0.06,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              "¡Bienvenido a nuestras transmisiones en vivo!",
              style: TextStyle(
                color: blanco,
                fontSize: screenWidth < 360 ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              "Únete a nosotros cada domingo a las 10:00 AM y miércoles a las 7:00 PM "
              "para nuestros servicios en vivo. También puedes ver nuestras transmisiones "
              "recientes cuando quieras.",
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

  Widget _buildRecentStream(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Text(
            "Transmisiones Recientes",
            style: getThema(screenWidth),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: double.infinity,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              color: colorWithOpacity(negro, 0.8),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: colorWithOpacity(blanco, 0.2)),
            ),
            child: TransmisionReciente(),
          ),
        ],
      ),
    );
  }
}
