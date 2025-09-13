import 'package:flutter/material.dart';
import '../Informacion/mapa.dart';
import '../Informacion/whatsapp.dart';
import '../Informacion/numero.dart';
import '../home/constantes.dart';

class Iglesia extends StatelessWidget {
  const Iglesia({super.key});

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
                _buildIntroText(screenWidth),
                Divider(color: gris),
                _buildPastorSection(screenWidth),
                _buildScheduleSection(screenWidth, screenHeight),
                _buildVisionMisionSection(screenWidth),
                _buildPastoresSection(screenWidth, screenHeight),
                _buildContactSection(context, screenWidth),
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
              "Seamos Iglesia",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/logo.png",
            height: screenHeight * 0.05,
            color: blanco,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.church,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "San Pedro Sula",
            style: TextStyle(
              color: blanco,
              fontSize: screenWidth < 360 ? 14 : 16,
            ),
          ),
          SizedBox(height: screenWidth * 0.05),
        ],
      ),
    );
  }

  Widget _buildIntroText(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Text(
        "Ser comunidad es fundamental para crecer juntos y fortalecernos. "
        "Cuando nos unimos como comunidad, podemos compartir nuestras experiencias, "
        "conocimientos y habilidades, lo que nos permite aprender unos de otros y crecer juntos.",
        style: TextStyle(
          fontSize: screenWidth < 360 ? 16 : 18,
          height: 1.5,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildPastorSection(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.2,
            scale: 1,
            image: const AssetImage("assets/images/logo.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("- Nuestro Pastor", style: getThema(screenWidth)),
            SizedBox(height: screenWidth * 0.02),
            Text(
              'Mario Valencia.',
              style: TextStyle(
                color: blanco,
                fontSize: screenWidth < 360 ? 16 : 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const _PastorMessage(),
            SizedBox(height: screenWidth * 0.05),
            Divider(color: gris),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSection(double screenWidth, double screenHeight) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getHorizontalPadding(screenWidth)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.18,
            child: Image.asset(
              "assets/images/horarios.png",
              fit: BoxFit.contain,
              opacity: AlwaysStoppedAnimation(0.3),
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.schedule,
                  size: screenHeight * 0.1,
                  color: colorWithOpacity(blanco, 0.3),
                );
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildVisionMisionSection(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _VisionSection(),
          _MisionSection(),
          SizedBox(height: 20),
          Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildPastoresSection(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Center(
          child: Text("Pastores", style: getThema(screenWidth)),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
          height: screenHeight * 0.18,
          child: ListView(
            scrollDirection: Axis.horizontal,
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
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Card(
        color: const Color.fromARGB(20, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: const [
              Text("Contáctanos",
                  style: TextStyle(
                      color: blanco,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(height: 20),
              Mapa('mapa'),
              SizedBox(height: 20),
              Telefono('celular'),
              SizedBox(height: 20),
              WhatsApp('mapa'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
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
        SizedBox(height: 14),
        _PastorText(
          'Durante años hemos orado para que Dios nos permita ser luz y sal de está hermosa ciudad de San Pedro Sula. Creemos firmemente en la '
          'restauración y el crecimiento integral de la familia y estamos para apoyarle para que se vea reflejado en su familia.',
        ),
        SizedBox(height: 14),
        _PastorText(
          'Es para nosotros, como familia pastoral, una gran alegría contar con su con su visita y será una bendición si usted decide hacer del '
          'Centro Cristiano Internacional San Pedro Sula, su casa! Declaramos sobre su vida la promesa de Dios que dice:',
        ),
        _PastorText(
          '"Pues yo sé los planes que tengo para ustedes —dice el SEÑOR —. Son planes para lo bueno y no para lo malo, para darles un futuro y una esperanza." Jeremías 29:11',
          isItalic: true,
        ),
        SizedBox(height: 14),
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
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: blanco,
        fontSize: screenWidth < 360 ? 15 : 18,
        fontWeight: isItalic ? FontWeight.normal : FontWeight.w300,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
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
        Text("Visión", style: getThema(screenWidth)),
        Text(
          "Ser una iglesia comprometida con la restauración de individuos, familias y ministerios, "
          "que provoca cambios sostenidos, logrando así alcanzar con el evangelio de Jesús a nuestra comunidad, la nación y el mundo.",
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: blanco,
            fontSize: screenWidth < 360 ? 15 : 18,
            fontWeight: FontWeight.w300,
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
        Text("Misión", style: getThema(screenWidth)),
        Text(
          "Alcanzar con el evangelio a la sociedad de San Pedro Sula, Honduras y el Mundo, formando en cada creyente un discípulo de Cristo "
          "altamente involucrado en la restauración de la salud espiritual, moral y material de las familias de nuestra comunidad y del mundo.",
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: blanco,
            fontSize: screenWidth < 360 ? 15 : 18,
            fontWeight: FontWeight.w300,
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
