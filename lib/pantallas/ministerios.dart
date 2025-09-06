import 'package:flutter/material.dart';
import '../Informacion/produccion.dart';
import '../Informacion/Worship.dart';
import '../home/constantes.dart';
import '../redes sociales/ig_alive.dart';

class Ministerios extends StatelessWidget {
  const Ministerios({super.key});

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
                _buildDescription(screenWidth),
                _buildMinisteriosList(screenWidth, screenHeight),
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
              "Ministerios CCI",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/logo.png",
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
        "La comunidad de CCI en San Pedro Sula está compuesta por muchos Ministerios "
        "con el fin de poder responder a las necesidades que cada etapa de la vida "
        "nos presenta. Te invitamos a conocerlos para que puedas ser parte también!",
        style: TextStyle(
          height: 1.5,
          fontSize: screenWidth < 360 ? 16 : 18,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildMinisteriosList(double screenWidth, double screenHeight) {
    return Column(
      children: [
        _buildMinisterioItem(
          "alabanza",
          "Ser un ministerio entendido de nuestra función como siervos que disciernen "
              "la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio "
              "guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es "
              "Él y lo que ha hecho por nosotros.",
          () => const FormWorship(),
          "Forma parte de nuestro equipo!",
          screenWidth,
          screenHeight,
        ),
        _buildMinisterioItem(
          "produccion",
          "Ser un ministerio entendido de nuestra función como siervos que disciernen "
              "la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio "
              "guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es "
              "Él y lo que ha hecho por nosotros.",
          () => const FormProduccion(),
          "Forma parte de nuestro equipo!",
          screenWidth,
          screenHeight,
        ),
        _buildMinisterioSocialItem(
          "alive",
          "Ser un ministerio entendido de nuestra función como siervos que disciernen "
              "la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio "
              "guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es "
              "Él y lo que ha hecho por nosotros.",
          const IgAlive('Instagram'),
          screenWidth,
          screenHeight,
        ),
      ],
    );
  }

  Widget _buildMinisterioItem(
    String image,
    String description,
    VoidCallback onTap,
    String buttonText,
    double screenWidth,
    double screenHeight,
  ) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.07),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.15,
            child: Image.asset(
              "assets/images/$image.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorWithOpacity(gris, 0.3),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Icon(
                    Icons.music_note,
                    size: screenWidth * 0.2,
                    color: colorWithOpacity(blanco, 0.5),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            description,
            style: TextStyle(
              color: blanco,
              fontSize: screenWidth < 360 ? 14 : 15,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.02),
          Center(
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: blanco,
                foregroundColor: negro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.015,
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: negro,
                  fontSize: screenWidth < 360 ? 14 : 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinisterioSocialItem(
    String image,
    String description,
    Widget socialButton,
    double screenWidth,
    double screenHeight,
  ) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.07),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.15,
            child: Image.asset(
              "assets/images/$image.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorWithOpacity(gris, 0.3),
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: colorWithOpacity(blanco, 0.2)),
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
            description,
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
            children: [socialButton],
          ),
        ],
      ),
    );
  }
}
