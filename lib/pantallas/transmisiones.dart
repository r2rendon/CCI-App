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
      body: SafeArea(
        child: SingleChildScrollView(
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
              "En vivo",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/logo.png",
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
    return Column(
      children: [
        Divider(color: gris),
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: const YoutubePlayerComponent(),
        ),
        SizedBox(height: screenHeight * 0.02),
        Divider(color: gris),
      ],
    );
  }

  Widget _buildWelcomeMessage(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hola Familia! Aquí puedes conectarte a nuestras transmisiones en vivo de "
            "todas las celebraciones para que no te pierdas esa palabra que Dios tiene para ti. "
            "Disfrutemos juntos de este tiempo!",
            style: TextStyle(
              height: 1.5,
              fontSize: screenWidth < 360 ? 16 : 18,
              color: blanco,
            ),
          ),
          SizedBox(height: screenWidth * 0.05),
          Divider(color: gris),
          SizedBox(height: screenWidth * 0.05),
          Text(
            "Aquí puedes ver nuestro mensaje más reciente!",
            style: TextStyle(
              height: 1.5,
              fontSize: screenWidth < 360 ? 16 : 18,
              color: blanco,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
        ],
      ),
    );
  }

  Widget _buildRecentStream(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: const YoutubePlayerComponent1(),
        ),
        SizedBox(height: screenHeight * 0.02),
        Divider(color: gris),
      ],
    );
  }
}
