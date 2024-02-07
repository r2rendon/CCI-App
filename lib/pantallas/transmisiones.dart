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
                children: const [
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
                    "¡Hola a todos! Les invitamos cordialmente a unirse al live de "
                    "la celebración Especial de CCI San Pedro Sula.",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
