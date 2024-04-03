import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Eventos extends StatelessWidget {
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
                      "LA VERDADERA GRANDEZA",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: blanco),
                    ),
                    Center(
                      child: Text(
                        "Serie Mes de Abril",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: blanco,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      "No hay mejor manera de servir",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "1. Como el que sirve.",
                      style: TextStyle(color: barr),
                    ),
                    Text(
                      "2. Acciones Sinceras.",
                      style: TextStyle(color: barr),
                    ),
                    Text(
                      "3. Unidos.",
                      style: TextStyle(color: barr),
                    ),
                    Text(
                      "4. Confiables.",
                      style: TextStyle(color: barr),
                    ),
                    const SizedBox(height: 20),
                    Divider(),
                    const SizedBox(height: 20),
                    Text(
                      "EVENTOS DE ABRIL",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: blanco),
                    ),
                    Card(
                      elevation: 1,
                      color: gris,
                      borderOnForeground: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "Conferencia Especializada",
                            style: TextStyle(
                              fontSize: 18,
                              color: blanco,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            " - Viernes 26 de Abril",
                            style: TextStyle(
                              // fontSize: 18,
                              color: blanco,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "  - Templo CCI SPS",
                            style: TextStyle(
                              // fontSize: 18,
                              color: blanco,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
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
