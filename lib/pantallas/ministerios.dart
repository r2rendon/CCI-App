import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Ministerios extends StatelessWidget {
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

                  //ofrendas icon
                  Icon(
                    Icons.person_3,
                    color: Colors.grey[800],
                    size: 43,
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
                    "Ministerios CCI",
                    style: TextStyle(
                      fontSize: 40,
                      height: 0,
                    ),
                  ),
                  //Desarrollo aqui
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
                    "La comunidad de CCI en San Pedro Sula está compuesta por muchos Ministerios con el fin de poder responder a las necesidades "
                    "que cada etapa de la vida nos presenta. Te invitamos a conocerlos para que puedas ser parte también!",
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
