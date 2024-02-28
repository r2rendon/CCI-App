import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Ofrendas extends StatelessWidget {
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
                    Icons.mobile_friendly,
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
                    "Diezmos y Ofrendas",
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
                    "Hemos dispuesto nuestras cuentas bancarias para que puedas dar tus diezmos y ofrendas",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                  Text(
                    "Proverbios 3:9-10",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Honra al Señor con tus riquezas y con lo mejor de todo lo que produces. Entonces él llenará tus graneros,  y tus tinajas se desbordarán de buen vino.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/bac.png",
                ),
                const SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/atlantida.png",
                ),
                const SizedBox(height: 20),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
