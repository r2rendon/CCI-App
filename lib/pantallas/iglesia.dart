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

            //Serie implementado desde FireBase
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/Serie.png",
                    opacity: AlwaysStoppedAnimation(.8),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "SI TÚ LO DICES",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Serie Mes de Febrero",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Text(
                    "Enseñar a la congregación acerca de cómo al creer en lo que Dios ha prometido, "
                    "en quien es El para nosotros, podemos ver como sus Palabras llenas de poder y autoridad "
                    "transforman nuestras vidas. ¿Pero qué tipo de Fe se requiere? ¿Fe en Quien? Seremos "
                    "estimulados a actuar y vivir porque Él lo ha dicho.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text("1. Creo en Ti"),
                  Text("2. Tus planes, no los míos"),
                  Text("3. Porque Tú lo dices"),
                  Text("4. Promesa Segura"),
                  Text("5. Apartados"),
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
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Ser una iglesia comprometida con la restauración de individuos, familias y ministerios, "
                    "que provoca cambios sostenidos, logrando así alcanzar con el evangelio de Jesús a nuestra comunidad, la nación y el mundo.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "Misión",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Alcanzar con el evangelio a la sociedad de San Pedro Sula, Honduras  y el Mundo, formando en cada creyente un discípulo de Cristo "
                    "altamente involucrado en la restauración de la salud espiritual, moral y material de las familias de nuestra comunidad y del mundo. ",
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
