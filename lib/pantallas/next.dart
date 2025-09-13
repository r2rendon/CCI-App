import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../redes sociales/ig_next.dart';

class Next extends StatelessWidget {
  const Next({super.key});

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
                _buildDescription(screenWidth),
                _buildNextInfo(screenWidth, screenHeight),
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
              "Next Generation",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/next.png",
            height: screenHeight * 0.05,
            color: blanco,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.people,
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

  Widget _buildDescription(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Text(
        "Next Generation es nuestro ministerio enfocado en los jóvenes y adolescentes. "
        "Creemos en el potencial de la próxima generación para impactar el mundo con el amor de Cristo.",
        style: TextStyle(
          height: 1.5,
          fontSize: screenWidth < 360 ? 16 : 18,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildNextInfo(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.07),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.15,
            child: Image.asset(
              "assets/images/next.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorWithOpacity(gris, 0.3),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Icon(
                    Icons.people,
                    size: screenWidth * 0.2,
                    color: colorWithOpacity(blanco, 0.5),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Únete a Next Generation y sé parte de una comunidad que busca crecer "
            "espiritualmente mientras se divierte y forma amistades duraderas. "
            "Tenemos actividades, estudios bíblicos y eventos especiales diseñados "
            "específicamente para jóvenes como tú.",
            style: TextStyle(
              color: blanco,
              fontSize: screenWidth < 360 ? 14 : 15,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [const IgNext('Instagram')],
          ),
        ],
      ),
    );
  }
}
