import 'package:flutter/material.dart';
import '../Informacion/mapa.dart';
import '../Informacion/whatsapp.dart';
import '../Informacion/numero.dart';
import '../home/constantes.dart';
import '../widgets/swipe_back_wrapper.dart';

class Iglesia extends StatelessWidget {
  const Iglesia({super.key});

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
                _buildIntroText(screenWidth),
                SizedBox(height: screenHeight * 0.03),
                _buildPastorSection(screenWidth),
                _buildScheduleSection(screenWidth, screenHeight),
                _buildVisionMisionSection(screenWidth),
                _buildPastoresSection(screenWidth, screenHeight),
                _buildContactSection(context, screenWidth),
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
      "Seamos Iglesia",
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

  Widget _buildIntroText(double screenWidth) {
    return Text(
      "Ser comunidad es fundamental para crecer juntos y fortalecernos. "
      "Cuando nos unimos como comunidad, podemos compartir nuestras experiencias, "
      "conocimientos y habilidades, lo que nos permite aprender unos de otros y crecer juntos.",
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: screenWidth < 360 ? 15 : 17,
        height: 1.6,
        color: grisMedio,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
      ),
    );
  }

  Widget _buildPastorSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nuestro Pastor",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
              Text(
              'Mario Valencia',
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                color: blanco,
                fontSize: screenWidth < 360 ? 19 : 22,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
        SizedBox(height: screenWidth * 0.04),
        const _PastorMessage(),
        SizedBox(height: screenWidth * 0.06),
      ],
    );
  }

  Widget _buildScheduleSection(double screenWidth, double screenHeight) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.04),
        Container(
          width: double.infinity,
          height: screenHeight * 0.18,
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
            child: Image.asset(
              "assets/images/horarios.png",
              fit: BoxFit.contain,
              opacity: AlwaysStoppedAnimation(0.5),
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.schedule_outlined,
                    size: screenHeight * 0.1,
                    color: grisMedio,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisionMisionSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _VisionSection(),
        _MisionSection(),
      ],
    );
  }

  Widget _buildPastoresSection(double screenWidth, double screenHeight) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.04),
        Text(
          "Pastores",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Container(
          height: screenHeight * 0.18,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              _PastorImage("mario"),
              _PastorImage("karla"),
              _PastorImage("juanramon"),
              _PastorImage("rosa"),
              _PastorImage("juanca"),
              _PastorImage("kensy"),
              _PastorImage("alejandro"),
              _PastorImage("gaby"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context, double screenWidth) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight * 0.04),
        Text(
          "Contáctanos",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
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
            children: const [
              Mapa('mapa'),
              SizedBox(height: 16),
              Telefono('celular'),
              SizedBox(height: 16),
              WhatsApp('mapa'),
            ],
          ),
        ),
      ],
    );
  }
}

class _PastorMessage extends StatelessWidget {
  const _PastorMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _PastorText(
          'En CCI podemos pero sobre todo queremos ser su iglesia, uno de mis mayores anhelos es ser parte como iglesia de la restauración y '
          'crecimiento espiritual personal y familiar.',
        ),
        SizedBox(height: 16),
        _PastorText(
          'Durante años hemos orado para que Dios nos permita ser luz y sal de está hermosa ciudad de San Pedro Sula. Creemos firmemente en la '
          'restauración y el crecimiento integral de la familia y estamos para apoyarle para que se vea reflejado en su familia.',
        ),
        SizedBox(height: 16),
        _PastorText(
          'Es para nosotros, como familia pastoral, una gran alegría contar con su visita y será una bendición si usted decide hacer del '
          'Centro Cristiano Internacional San Pedro Sula, su casa! Declaramos sobre su vida la promesa de Dios que dice:',
        ),
        SizedBox(height: 16),
        _PastorText(
          '"Pues yo sé los planes que tengo para ustedes —dice el SEÑOR —. Son planes para lo bueno y no para lo malo, para darles un futuro y una esperanza." Jeremías 29:11',
          isItalic: true,
        ),
        SizedBox(height: 16),
        _PastorText(
          '¡Y Oramos que Dios le bendiga abundantemente y le esperamos cada domingo para disfrutar y seguir siendo parte de la familia CCI!',
        ),
      ],
    );
  }
}

class _PastorText extends StatelessWidget {
  final String text;
  final bool isItalic;

  const _PastorText(this.text, {this.isItalic = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Text(
      text,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        color: grisMedio,
        fontSize: screenWidth < 360 ? 15 : 17,
        fontWeight: isItalic ? FontWeight.w400 : FontWeight.w400,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        letterSpacing: 0.0,
        height: 1.6,
      ),
    );
  }
}

class _VisionSection extends StatelessWidget {
  const _VisionSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Visión",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          "Ser una iglesia comprometida con la restauración de individuos, familias y ministerios, "
          "que provoca cambios sostenidos, logrando así alcanzar con el evangelio de Jesús a nuestra comunidad, la nación y el mundo.",
          overflow: TextOverflow.visible,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: grisMedio,
            fontSize: screenWidth < 360 ? 15 : 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.0,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _MisionSection extends StatelessWidget {
  const _MisionSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.04),
        Text(
          "Misión",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: blanco,
            fontSize: screenWidth < 360 ? 20 : 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          "Alcanzar con el evangelio a la sociedad de San Pedro Sula, Honduras y el Mundo, formando en cada creyente un discípulo de Cristo "
          "altamente involucrado en la restauración de la salud espiritual, moral y material de las familias de nuestra comunidad y del mundo.",
          overflow: TextOverflow.visible,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            color: grisMedio,
            fontSize: screenWidth < 360 ? 15 : 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.0,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _PastorImage extends StatelessWidget {
  final String name;

  const _PastorImage(this.name);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: screenHeight * 0.13,
      height: screenHeight * 0.13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorWithOpacity(blanco, 0.1),
        border: Border.all(color: colorWithOpacity(blanco, 0.2)),
      ),
      child: ClipOval(
        child: Image.asset(
          "assets/images/$name.png",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.person,
              size: screenHeight * 0.08,
              color: colorWithOpacity(blanco, 0.5),
            );
          },
        ),
      ),
    );
  }
}
