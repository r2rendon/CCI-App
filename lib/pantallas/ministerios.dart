import 'package:flutter/material.dart';
import '../Informacion/produccion.dart';
import '../Informacion/Worship.dart';
import '../utils/constants.dart';
import '../widgets/swipe_back_wrapper.dart';
import '../redes sociales/ig_alive.dart';
import '../redes sociales/ig_next.dart';
import '../redes sociales/ig_matrimonios.dart';
import '../redes sociales/ig_mujeres.dart';
import '../redes sociales/ig_shift.dart';
import '../redes sociales/fb_hombres.dart';

class Ministerios extends StatelessWidget {
  const Ministerios({super.key});

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
                _buildMinisteriosList(screenWidth, screenHeight),
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
      "Ministerios CCI",
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
        letterSpacing: -0.41,
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
        _buildMinisterioSocialItem(
          "next",
          "Únete a Next Generation y sé parte de una comunidad que busca crecer "
              "espiritualmente mientras se divierte y forma amistades duraderas. "
              "Tenemos actividades, estudios bíblicos y eventos especiales diseñados "
              "específicamente para jóvenes como tú.",
          const IgNext('Instagram'),
          screenWidth,
          screenHeight,
        ),
        _buildMinisterioSocialItem(
          "matrimonios",
          "Un ministerio dedicado a fortalecer y enriquecer los matrimonios, "
              "proporcionando herramientas, recursos y comunidad para parejas que buscan "
              "crecer juntas en su relación y en su fe.",
          const IgMatrimonios('Instagram'),
          screenWidth,
          screenHeight,
        ),
        _buildMinisterioSocialItem(
          "hombres",
          "Un ministerio enfocado en el crecimiento espiritual y personal de los hombres, "
              "proporcionando un espacio de comunidad, apoyo y desarrollo donde los hombres "
              "pueden fortalecer su fe y sus relaciones.",
          const FbHombres('Facebook'),
          screenWidth,
          screenHeight,
        ),
        _buildMinisterioSocialItem(
          "mujeres",
          "Un ministerio dedicado a empoderar y fortalecer a las mujeres en su fe y vida diaria, "
              "ofreciendo comunidad, apoyo y recursos para el crecimiento espiritual y personal.",
          const IgMujeres('Instagram'),
          screenWidth,
          screenHeight,
        ),
        _buildMinisterioSocialItem(
          "shift",
          "Un ministerio dinámico enfocado en el crecimiento y desarrollo de la próxima generación, "
              "proporcionando un espacio donde los jóvenes pueden conectarse, crecer espiritualmente "
              "y hacer un impacto positivo en su comunidad.",
          const IgShift('Instagram'),
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
            mainAxisSize: MainAxisSize.min,
            children: [socialButton],
          ),
        ],
      ),
    );
  }
}
