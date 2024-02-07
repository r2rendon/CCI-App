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
              padding: EdgeInsets.symmetric(horizontal: 35),
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
              padding: EdgeInsets.symmetric(horizontal: 35),
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

            //Extra

            const SizedBox(height: 20),
            Center(
              child: Text(
                "Contáctanos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
                "Honduras, San Pedro Sula, Colonia Trejo 9 calle, 21 y 22 avenida."),
            Text("+504-2510-1731"),
            Text("iglesia@ccisanpedrosula.org"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
