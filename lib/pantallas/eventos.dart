import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Eventos extends StatelessWidget {
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

                  //eventos icon
                  Icon(
                    Icons.groups_2_outlined,
                    size: 45,
                    color: Colors.grey[800],
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
                    "Eventos del mes",
                    style: TextStyle(
                      fontSize: 40,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hola! Tú eres parte de la gran familia de CCI San Pedro Sula, y por esto queremos que estés enterado de todo lo que se viene! "
                    "Aquí encontrarás los próximos eventos para que puedas agendar las fechas y no te pierdas de nada.",
                    style: TextStyle(
                      fontSize: 18,
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
          ],
        ),
      ),
    );
  }
}
