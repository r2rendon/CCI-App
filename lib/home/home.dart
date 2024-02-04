import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../pantallas/eventos.dart';
import '../pantallas/iglesia.dart';
import '../pantallas/ofrendas.dart';
import '../pantallas/transmisiones.dart';
import 'constantes.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Color.fromARGB(164, 235, 235, 235),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "assets/images/mundo.jpg",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            //Transmisiones en vivo
            Container(
              child: Positioned(
                left: 29,
                top: 270, //Altura del glass
                child: GlassmorphicContainer(
                  // width: 350,
                  width: 300,
                  // height: 750,
                  height: 50,
                  borderRadius: 20,
                  blur: 0.5,

                  border: 0,
                  linearGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.1),
                      Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ],
                  ),
                  borderGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.5),
                      Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  //Informacion
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Positioned(
                          child: Icon(
                            Icons.videocam_outlined,
                            color: blanco,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              color: blanco,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Transmisiones(),
                              ),
                            );
                          },
                          child: const Text(
                            '  Transmisiones en vivo      ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: blanco,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Eventos
            Container(
              child: Positioned(
                left: 29,
                top: 330, //Altura del glass
                child: GlassmorphicContainer(
                  // width: 350,
                  width: 300,
                  // height: 750,
                  height: 50,
                  borderRadius: 20,
                  blur: 0.5,

                  border: 0,
                  linearGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.1),
                      Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ],
                  ),
                  borderGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.5),
                      Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  //Informacion
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Positioned(
                          child: Icon(
                            Icons.groups_2_outlined,
                            color: blanco,
                          ),
                        ),
                        Positioned(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Eventos(),
                                ),
                              );
                            },
                            child: const Text(
                              '              Eventos                   ',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: blanco,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Ofrendas
            Container(
              child: Positioned(
                left: 29,
                top: 390.5, //Altura del glass
                child: GlassmorphicContainer(
                  // width: 350,
                  width: 300,
                  // height: 750,
                  height: 50,
                  borderRadius: 20,
                  blur: 0.5,

                  border: 0,
                  linearGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.1),
                      Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ],
                  ),
                  borderGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.5),
                      Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  //Informacion
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Positioned(
                          child: Icon(
                            Icons.mobile_friendly,
                            color: blanco,
                          ),
                        ),
                        Positioned(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Ofrendas(),
                                ),
                              );
                            },
                            child: const Text(
                              '              Ofrendas                   ',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: blanco,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Iglesia
            Container(
              child: Positioned(
                left: 29,
                top: 451.5, //Altura del glass
                child: GlassmorphicContainer(
                  // width: 350,
                  width: 300,
                  // height: 750,
                  height: 50,
                  borderRadius: 20,
                  blur: 0.5,

                  border: 0,
                  linearGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.1),
                      Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ],
                  ),
                  borderGradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.5),
                      Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  //Informacion
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Positioned(
                          child: Icon(
                            Icons.church_outlined,
                            color: blanco,
                          ),
                        ),
                        Positioned(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Iglesia(),
                                ),
                              );
                            },
                            child: const Text(
                              '      Quienes somos?             ',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: blanco,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
