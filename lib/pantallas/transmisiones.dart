import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../utils/YouTubePlayer.dart';

class Transmisiones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                gris,
                negro,
              ],
            ),
          ),
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
                    Text(
                      "En vivo",
                      style: TextStyle(
                        fontSize: 35,
                        height: 0,
                        color: blanco,
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
              //Descripcion de funtion
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "San Pedro Sula",
                      style: TextStyle(
                        color: blanco,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Divider(),
              //Transmision
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    YoutubePlayerComponent(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Divider(),
              const SizedBox(height: 20),

              //Descripcion 1
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hola Familia! Aquí puedes conectarte a nuestras transmisiones en vivo de "
                      "todas las celebraciones para que no te pierdas esa palabra que Dios tiene para ti. Disfrutemos juntos de este tiempo!",
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
            ],
          ),
        ),
      ),
    );
  }
}
