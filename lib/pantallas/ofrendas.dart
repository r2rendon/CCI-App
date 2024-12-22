import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Ofrendas extends StatelessWidget {
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
                      "Dar",
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
              //Centro Cristiano Internacional
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hemos dispuesto nuestras cuentas bancarias para que puedas dar tus diezmos y ofrendas",
                      style: TextStyle(
                        fontSize: 18,
                        height: 0,
                        color: blanco,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      color: gris,
                    ),
                    Text(
                      "Proverbios 3:9-10",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blanco,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Honra al Señor con tus riquezas y con lo mejor de todo lo que produces. Entonces él llenará tus graneros,  y tus tinajas se desbordarán de buen vino.',
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: blanco,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      color: gris,
                    ),
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
                  Divider(
                    color: gris,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
