import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../widgets/swipe_back_wrapper.dart';
import '../redes sociales/ig_next.dart';

class Next extends StatelessWidget {
  const Next({super.key});

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
                SizedBox(height: screenHeight * 0.04),
                _buildDescription(screenWidth),
                _buildNextInfo(screenWidth, screenHeight),
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
      "Next Generation",
      overflow: TextOverflow.visible,
      style: getTitulo(screenWidth),
    );
  }

  Widget _buildLocation(double screenWidth) {
    return Text(
      "San Pedro Sula",
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        color: grisMedio,
        fontSize: screenWidth < 360 ? 15 : 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.41,
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
        overflow: TextOverflow.visible,
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
            overflow: TextOverflow.visible,
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
            mainAxisSize: MainAxisSize.min,
            children: [const IgNext('Instagram')],
          ),
        ],
      ),
    );
  }
}
