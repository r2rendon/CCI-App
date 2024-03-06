import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Eventos extends StatelessWidget {
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
                    //Eventos del mes
                    Text(
                      "Eventos del mes",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 35,
                        height: 0,
                        fontWeight: FontWeight.w300,
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
                      "Hola! Tú eres parte de la gran familia de CCI San Pedro Sula, y por esto queremos que estés enterado de todo lo que se viene! "
                      "Aquí encontrarás los próximos eventos para que puedas agendar las fechas y no te pierdas de nada.",
                      style: TextStyle(
                        fontSize: 18,
                        color: blanco,
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
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/Serie.png",
                      opacity: AlwaysStoppedAnimation(.3),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "SI TÚ LO DICES",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: blanco),
                    ),
                    Center(
                      child: Text(
                        "Serie Mes de Febrero",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: blanco,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      "Enseñar a la congregación acerca de cómo al creer en lo que Dios ha prometido, "
                      "en quien es El para nosotros, podemos ver como sus Palabras llenas de poder y autoridad "
                      "transforman nuestras vidas. ¿Pero qué tipo de Fe se requiere? ¿Fe en Quien? Seremos "
                      "estimulados a actuar y vivir porque Él lo ha dicho.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "1. Creo en Ti",
                      style: TextStyle(color: barr),
                    ),
                    Text(
                      "2. Tus planes, no los míos",
                      style: TextStyle(color: barr),
                    ),
                    Text(
                      "3. Porque Tú lo dices",
                      style: TextStyle(color: barr),
                    ),
                    Text(
                      "4. Promesa Segura",
                      style: TextStyle(color: barr),
                    ),
                    Text(
                      "5. Apartados",
                      style: TextStyle(color: barr),
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
