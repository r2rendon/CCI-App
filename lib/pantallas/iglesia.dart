import 'package:cci_app/Informacion/mapa.dart';
import 'package:flutter/material.dart';
import '../Informacion/whatsapp.dart';
import '../home/constantes.dart';
import '../Informacion/numero.dart';

class Iglesia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: SingleChildScrollView(
        child: Container(
          decoration: Decorations,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: verticalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //logo cci
                    Text(
                      "Seamos Iglesia",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 35,
                        height: 0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    //logo cci
                    Image.asset(
                      "assets/images/logo.png",
                      height: 45,
                      color: blanco,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              //Centro Cristiano Internacional
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "San Pedro Sula",
                      style: TextStyle(
                        color: blanco,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Text(
                  "Ser comunidad es fundamental para crecer juntos y fortalecernos, "
                  "Cuando nos unimos como comunidad, podemos compartir nuestras experiencias, "
                  "conocimientos y habilidades, lo que nos permite aprender unos de otros y crecer juntos.",
                  // textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: blanco,
                    fontSize: 18,
                    height: 0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Divider(),

              //Nuestro Pastor
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: .2,
                      scale: 1,
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "- Nuestro Pastor",
                        textAlign: TextAlign.center,
                        style: thema,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Mario Valencia.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: blanco,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'En CCI podemos pero sobre todo queremos ser su iglesia, uno de mis mayores anhelos es ser parte como iglesia de la restauración y '
                        'crecimiento espiritual personal y familiar.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: blanco,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Durante años hemos orado para que Dios nos permita ser luz y sal de está hermosa ciudad de San Pedro Sula. Creemos firmemente en la '
                        'restauración y el crecimiento integral de la familia y estamos para apoyarle para que se vea reflejado en su familia.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: blanco,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Es para nosotros, como familia pastoral, una gran alegría contar con su con su visita y será una bendición si usted decide hacer del '
                        'Centro Cristiano Internacional San Pedro Sula, su casa! Declaramos sobre su vida la promesa de Dios que dice:',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: blanco,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        '“Pues yo sé los planes que tengo para ustedes —dice el SEÑOR —. Son planes para lo bueno y no para lo malo, para darles un futuro y una esperanza.” Jeremías 29:11',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: blanco,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '¡Y Oramos que Dios le bendiga abundantemente y le esperamos cada domingo para disfrutar y seguir siendo parte de la familia CCI!',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: blanco,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Divider(),
                    ],
                  ),
                ),
              ),

              //Horarios
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/horarios.png",
                      opacity: AlwaysStoppedAnimation(.3),
                    ),
                    const SizedBox(height: 20),
                    Divider(),
                  ],
                ),
              ),
              //Mision y vision
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Visión",
                      textAlign: TextAlign.center,
                      style: thema,
                    ),
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
                    Text(
                      "Misión",
                      textAlign: TextAlign.center,
                      style: thema,
                    ),
                    Text(
                      "Alcanzar con el evangelio a la sociedad de San Pedro Sula, Honduras  y el Mundo, formando en cada creyente un discípulo de Cristo "
                      "altamente involucrado en la restauración de la salud espiritual, moral y material de las familias de nuestra comunidad y del mundo. ",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: blanco,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Pastores",
                  textAlign: TextAlign.center,
                  style: thema,
                ),
              ),
              //Otro
              Container(
                decoration: Decorations,
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 200.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        "assets/images/mario.png",
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/karla.png",
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/juanramon.png",
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/rosa.png",
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/juanca.png",
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/kensy.png",
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/alejandro.png",
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/gaby.png",
                      ),
                    ),
                  ],
                ),
              ),

              //Informacion de contacto
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Card(
                  color: Color.fromARGB(28, 255, 255, 255),
                  child: Column(
                    children: [
                      Text(
                        "Contáctanos",
                        style: thema,
                      ),
                      const SizedBox(height: 20),
                      Mapa('mapa'),
                      const SizedBox(height: 20),
                      Telefono('celular'),
                      const SizedBox(height: 20),
                      WhatsApp('mapa'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
