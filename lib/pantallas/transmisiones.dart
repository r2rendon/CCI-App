import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../utils/YouTubePlayer.dart';

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
            Divider(),
            //Transmision
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  YoutubePlayerComponent(),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
            Divider(),
            //Descripcion 1
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hola Familia! Aquí puedes conectarte a nuestras transmisiones en vivo de "
                    "todas las celebraciones para que no te pierdas esa palabra que Dios tiene para ti. Disfrutemos juntos de este tiempo!",
                    // textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  // const SizedBox(height: 20),
                  Divider(),
                ],
              ),
            ),

            //Descripcion 2
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Esta es una gran oportunidad para conectarnos como comunidad y elevar nuestras oraciones juntos! '
                    'No importa donde estés en este momento, podrás unirte a nosotros desde la comodidad de tu hogar a través de nuestra App CCI.',
                    // textAlign: TextAlign.justify,
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
