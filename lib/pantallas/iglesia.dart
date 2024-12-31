import 'package:flutter/material.dart';
import '../Informacion/mapa.dart';
import '../Informacion/whatsapp.dart';
import '../Informacion/numero.dart';
import '../home/constantes.dart';

class Iglesia extends StatelessWidget {
  const Iglesia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: SingleChildScrollView(
        child: Container(
          decoration: decorations,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildLocation(),
              _buildIntroText(),
              const Divider(color: gris),
              _buildPastorSection(),
              _buildScheduleSection(),
              _buildVisionMisionSection(),
              _buildPastoresSection(),
              _buildContactSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Seamos Iglesia",
            style: titulo,
          ),
          Image.asset(
            "assets/images/logo.png",
            height: 45,
            color: blanco,
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "San Pedro Sula",
            style: TextStyle(color: blanco),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildIntroText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: Text(
        "Ser comunidad es fundamental para crecer juntos y fortalecernos. "
        "Cuando nos unimos como comunidad, podemos compartir nuestras experiencias, "
        "conocimientos y habilidades, lo que nos permite aprender unos de otros y crecer juntos.",
        style: TextStyle(
          fontSize: 18,
          height: 1.5,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildPastorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .2,
            scale: 1,
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("- Nuestro Pastor", style: thema),
            SizedBox(height: 6),
            Text(
              'Mario Valencia.',
              style: TextStyle(
                color: blanco,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            _PastorMessage(),
            SizedBox(height: 20),
            Divider(color: gris),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Image.asset(
            "assets/images/horarios.png",
            opacity: const AlwaysStoppedAnimation(.3),
          ),
          const SizedBox(height: 20),
          const Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildVisionMisionSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VisionSection(),
          _MisionSection(),
          SizedBox(height: 20),
          Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildPastoresSection() {
    return Column(
      children: [
        const Center(
          child: Text("Pastores", style: thema),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 200.0,
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

  Widget _buildContactSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Card(
        color: const Color.fromARGB(10, 255, 255, 255),
        child: Column(
          children: const [
            Text("Contáctanos", style: thema),
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
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: blanco,
        fontSize: 18,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Visión", style: thema),
        Text(
          "Ser una iglesia comprometida con la restauración de individuos, familias y ministerios, "
          "que provoca cambios sostenidos, logrando así alcanzar con el evangelio de Jesús a nuestra comunidad, la nación y el mundo.",
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: blanco,
            fontSize: 18,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Misión", style: thema),
        Text(
          "Alcanzar con el evangelio a la sociedad de San Pedro Sula, Honduras y el Mundo, formando en cada creyente un discípulo de Cristo "
          "altamente involucrado en la restauración de la salud espiritual, moral y material de las familias de nuestra comunidad y del mundo.",
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: blanco,
            fontSize: 18,
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
    return Container(
      child: Image.asset("assets/images/$name.png"),
    );
  }
}

//develop branch promotion test...full process.