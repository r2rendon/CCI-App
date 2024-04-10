import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../utils/Transmision_Live.dart';
import '../utils/Transmision_Reciente.dart';

class Transmisiones extends StatelessWidget {
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
                    Text(
                      "En vivo",
                      style: titulo,
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
                        height: 0,
                        fontSize: 18,
                        color: blanco,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                      "Aqui puedes ver nuestra mensaje mas reciente!",
                      style: TextStyle(
                        height: 0,
                        fontSize: 18,
                        color: blanco,
                      ),
                    ),
                  ],
                ),
              ),
              //Predica anterior
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    YoutubePlayerComponent1(),
                    const SizedBox(height: 20),
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
