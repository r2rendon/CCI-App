import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Informacion/actividades_externas.dart';
import '../home/constantes.dart';

class Eventos extends StatelessWidget {
  // Título de la Serie
  Future<String> getSerieTitle() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('serieTitle').get();
    if (snapshot.exists) {
      return snapshot.value as String;
    }
    return '';
  }

  // Imagen de la Serie
  Future<String> getSerieImage() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('serieImage').get();
    if (snapshot.exists) {
      return snapshot.value as String;
    }
    return '';
  }

  // Temas de la Serie
  Future<String> getSerieThemes() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('serieThemes').get();
    if (snapshot.exists) {
      return snapshot.value as String;
    }
    return '';
  }

  // Eventos del mes
  Future<String> getMonthlyEvents() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('monthlyEvents').get();
    if (snapshot.exists) {
      return snapshot.value as String;
    }
    return '';
  }

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
                    // Eventos del mes
                    Text(
                      "Eventos del mes",
                      style: titulo,
                    ),
                    // Logo CCI
                    Image.asset(
                      "assets/images/logo.png",
                      height: 45,
                      color: blanco,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                        height:
                            1.5, // Ajusta la altura de la línea aquí si es necesario
                        fontSize: 18,
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
              // Serie implementada desde Firebase
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LA VERDADERA GRANDEZA',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: blanco),
                    ),
                    const SizedBox(height: 20),

                    Image.asset(
                      "assets/images/Serie.png",
                      opacity: AlwaysStoppedAnimation(.3),
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: Text(
                        "Serie del Mes",
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
                    Divider(
                      color: gris,
                    ),
                    //           APARTADO DE EVENTOS
                    Text(
                      "EVENTOS DE ABRIL",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: blanco),
                    ),
                    //              EVENTOS PARES
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

                    //                  EVENTOS IMPARES
                    //                  Shift Viernes 12 de Abril
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
