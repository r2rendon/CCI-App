import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Transmisiones extends StatelessWidget {
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

                  //camara icon
                  Icon(
                    Icons.videocam_outlined,
                    size: 45,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //Descripcion de funtion
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("San Pedro Sula"),
                  Text(
                    "Transmisiones en vivo",
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
                    "Hola Familia! Aquí puedes conectarte a nuestras transmisiones en vivo de "
                    "todas las celebraciones para que no te pierdas esa palabra que Dios tiene para ti. Disfrutemos juntos de este tiempo!",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/transmision.png",
                ),
                const SizedBox(height: 20),
              ],
            ),

            //Descripcion
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Esta es una gran oportunidad para conectarnos como comunidad y elevar nuestras oraciones juntos!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 9),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No importa donde estés en este momento, podrás unirte a nosotros desde la comodidad de tu hogar a través de nuestra App CCI.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
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
