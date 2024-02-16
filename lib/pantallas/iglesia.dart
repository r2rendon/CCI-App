import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Iglesia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //logo cci
                  Image.asset(
                    "assets/images/logo.png",
                    height: 45,
                    color: Colors.grey[800],
                  ),

                  //iglesia icon
                  Icon(
                    Icons.church_outlined,
                    color: Colors.grey[800],
                    size: 45,
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
                  Text("San Pedro Sula"),
                  Text(
                    "Seamos Iglesia",
                    style: TextStyle(
                      fontSize: 40,
                      height: 0,
                    ),
                  ),
                  Text(
                    "Ser comunidad es fundamental para crecer juntos y fortalecernos, "
                    "Cuando nos unimos como comunidad, podemos compartir nuestras experiencias, "
                    "conocimientos y habilidades, lo que nos permite aprender unos de otros y crecer juntos.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      height: 0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                ],
              ),
            ),
            //Nuestro Pastor
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    scale: 1,
                    image: AssetImage("assets/images/logo.png"),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "- Nuestro Pastor",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Mario Valencia.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      'En CCI podemos pero sobre todo queremos ser su iglesia, uno de mis mayores anhelos es ser parte como iglesia de la restauración y '
                      'crecimiento espiritual personal y familiar.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
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
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      '“Pues yo sé los planes que tengo para ustedes —dice el SEÑOR —. Son planes para lo bueno y no para lo malo, para darles un futuro y una esperanza.” Jeremías 29:11',
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '¡Y Oramos que Dios le bendiga abundantemente y le esperamos cada domingo para disfrutar y seguir siendo parte de la familia CCI!',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
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
                    opacity: AlwaysStoppedAnimation(.8),
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Ser una iglesia comprometida con la restauración de individuos, familias y ministerios, "
                    "que provoca cambios sostenidos, logrando así alcanzar con el evangelio de Jesús a nuestra comunidad, la nación y el mundo.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "Misión",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Alcanzar con el evangelio a la sociedad de San Pedro Sula, Honduras  y el Mundo, formando en cada creyente un discípulo de Cristo "
                    "altamente involucrado en la restauración de la salud espiritual, moral y material de las familias de nuestra comunidad y del mundo. ",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
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
                "Pastores Generales",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            //Mario Valencia
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mario Valencia",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastor General",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  new Image.asset(
                    "assets/images/mario.png",
                    scale: 12,
                  ),
                ],
              ),
            ),
            // Karla de Valencia
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Karla de Valencia",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastora General",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  new Image.asset(
                    "assets/images/karla.png",
                    scale: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //Pastores titulares
            Center(
              child: Text(
                "Pastores De Celebraciones",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            //Juan Ramon Tabora
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Juan Ramón Tábora",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastor Titular 9:00 a.m.",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  new Image.asset(
                    "assets/images/juanramon.png",
                    scale: 12.5,
                  ),
                ],
              ),
            ),
            //Rosa de Tabora
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rosa de Tábora",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastora Titular 9:00 a.m.",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  new Image.asset(
                    "assets/images/rosa.png",
                    scale: 12.5,
                  ),
                ],
              ),
            ),
            //Juan Carlos Vallecillo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Juan Carlos Vallecillo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastor Titular 11:30 a.m.",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  new Image.asset(
                    "assets/images/juanca.png",
                    scale: 12.5,
                  ),
                ],
              ),
            ),
            //Kensy de Vallecillo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kensy de Vallecillo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastora Titular 11:30 a.m.",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  new Image.asset(
                    "assets/images/kensy.png",
                    scale: 12.5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //Pastores Generacionales
            Center(
              child: Text(
                "Pastores de Nuevas Generaciones",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            //Alejandro Henriquez
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alejandro Henríquez",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastor Generacional",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  new Image.asset(
                    "assets/images/alejandro.png",
                    scale: 12.5,
                  ),
                ],
              ),
            ),
            //Gabriela de Henríquez
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gabriela de Henríquez",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Pastora Generacional",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  new Image.asset(
                    "assets/images/gaby.png",
                    scale: 12.5,
                  ),
                ],
              ),
            ),

            //Informacion de contacto
            const SizedBox(height: 20),
            Divider(),
            Center(
              child: Column(
                children: [
                  Text(
                    "Contáctanos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Honduras, San Pedro Sula, Colonia Trejo 9 calle, 21 y 22 avenida.",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "+504-2510-1731",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "iglesia@ccisanpedrosula.org",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
