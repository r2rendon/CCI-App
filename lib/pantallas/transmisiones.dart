import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../widgets/swipe_back_wrapper.dart';
import '../utils/Transmision_Live.dart';
import '../utils/Transmision_Reciente.dart';

class Transmisiones extends StatelessWidget {
  const Transmisiones({super.key});

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
                SizedBox(height: screenHeight * 0.06),
                _buildLiveStreamSection(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.04),
                _buildWelcomeMessage(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.06),
                _buildRecentStreamSection(screenWidth, screenHeight),
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
      "En Vivo",
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
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget _buildLiveStreamSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TRANSMISIÓN EN VIVO",
          style: getHeroSubtitle(screenWidth),
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.3,
          ),
          decoration: BoxDecoration(
            color: grisCard,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: colorWithOpacity(blanco, 0.1),
              width: 0.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: const TransmisionLive(),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeMessage(double screenWidth, double screenHeight) {
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
        children: [
          Icon(
            Icons.live_tv_outlined,
            color: accent,
            size: 32,
          ),
          SizedBox(height: screenWidth * 0.03),
          Text(
            "¡Bienvenido a nuestras transmisiones en vivo!",
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              color: blanco,
              fontSize: screenWidth < 360 ? 17 : 19,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.41,
              height: 1.35,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            "Únete a nosotros cada domingo a las 10:00 AM y miércoles a las 7:00 PM "
            "para nuestros servicios en vivo. También puedes ver nuestras transmisiones "
            "recientes cuando quieras.",
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              color: grisMedio,
              fontSize: screenWidth < 360 ? 15 : 17,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0,
              height: 1.6,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentStreamSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transmisiones Recientes",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.3,
          ),
          decoration: BoxDecoration(
            color: grisCard,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: colorWithOpacity(blanco, 0.1),
              width: 0.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: const TransmisionReciente(),
          ),
        ),
      ],
    );
  }
}
