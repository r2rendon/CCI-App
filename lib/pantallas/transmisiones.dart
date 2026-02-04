import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../utils/app_config.dart';
import '../widgets/swipe_back_wrapper.dart';
import '../utils/Transmision_Live.dart';

class Transmisiones extends StatelessWidget {
  const Transmisiones({super.key});

  Future<void> _openYouTubeChannel() async {
    final uri = Uri.parse(AppConfig.youtubeChannelUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                    ],
                  ),
                ),
                _buildLiveStreamSection(screenWidth, screenHeight),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getHorizontalPadding(screenWidth),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.04),
                      _buildWelcomeMessage(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
                _buildYouTubeChannelSection(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.06),
              ],
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getHorizontalPadding(screenWidth),
          ),
          child: Text(
            "Transmisión en vivo",
            style: getHeroSubtitle(screenWidth),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        const TransmisionLive(),
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
            "Únete a nosotros cada domingo a las 11:30 AM y miércoles a las 7:00 PM "
            "para nuestros servicios en vivo.",
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

  Widget _buildYouTubeChannelSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getHorizontalPadding(screenWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Predicaciones y contenido",
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
          SizedBox(height: screenHeight * 0.02),
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
              children: [
                Icon(
                  Icons.play_circle_outline,
                  color: accent,
                  size: 40,
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  "Descubre nuestro canal de YouTube para ver todas nuestras "
                  "predicaciones, transmisiones recientes y contenido exclusivo.",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: grisMedio,
                    fontSize: screenWidth < 360 ? 15 : 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.0,
                    height: 1.5,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenWidth * 0.05),
                FilledButton.icon(
                  onPressed: _openYouTubeChannel,
                  icon: const Icon(Icons.open_in_new, size: 20),
                  label: const Text('Ver canal en YouTube'),
                  style: FilledButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: 14,
                    ),
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
