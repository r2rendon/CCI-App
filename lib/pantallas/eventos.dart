import 'package:flutter/material.dart';
import '../Informacion/actividades_externas.dart';
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
                      "Hola! Tú eres parte de la gran familia de CCI San Pedro Sula, y por esto queremos que estés enterado de todo lo que se viene! "
                      "Aquí encontrarás los próximos eventos para que puedas agendar las fechas y no te pierdas de nada.",
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
                    //           APARTADO DE EVENTOS
                    Text(
                      "EVENTOS DE ABRIL",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: blanco),
                    ),
                    // Conferencia especializada viernes 26 de Abril
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 100,
                      ),
                      child: Card(
                        elevation: 1,
                        color: Color.fromARGB(10, 255, 255, 255),
                        borderOnForeground: true,
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Conferencia Especializada",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: blanco,
                                  fontWeight: FontWeight.bold,
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
                      ),
                    ),

                    // Shift Viernes 12 de Abril
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 100,
                      ),
                      child: Card(
                        elevation: 1,
                        color: Color.fromARGB(10, 255, 255, 255),
                        borderOnForeground: true,
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Shift Night",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: blanco,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " - Viernes 12 de Abril",
                                style: TextStyle(
                                  // fontSize: 18,
                                  color: blanco,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "  - Kilo Bistro",
                                style: TextStyle(
                                  // fontSize: 18,
                                  color: blanco,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Externa('mapa'),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Otro evento sabado 13
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 100,
                      ),
                      child: Card(
                        elevation: 1,
                        color: Color.fromARGB(10, 255, 255, 255),
                        borderOnForeground: true,
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Otro Evento/Actrividad",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: blanco,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " - Sabado 13 de Abril",
                                style: TextStyle(
                                  // fontSize: 18,
                                  color: blanco,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "  - ejemplo de Witget plus",
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
                      ),
                    ),
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
