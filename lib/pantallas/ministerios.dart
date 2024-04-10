import 'package:flutter/material.dart';
import '../Informacion/Worship.dart';
import '../home/constantes.dart';

class Ministerios extends StatelessWidget {
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
                      "Ministerios CCI",
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
                        height: 0,
                        fontSize: 18,
                        color: blanco,
                      ),
                    ),
                  ],
                ),
              ),
              //Apartado de alabanza
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Container(
                      child: Image.asset("assets/images/alabanza.png"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "En este apartado se le dara una introduccion al ministerio de aladdbanza",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormWorship(),
                            ),
                          );
                        },
                        child: Text("Quiero formar parte!"),
                      ),
                    ),
                  ],
                ),
              ),

              //Apartado de produccion
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/produccion.png"),
                    const SizedBox(height: 20),
                    Text(
                      "En este apartado se le dara una introduccion al ministerio de produccion",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              //Apartado de alive
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/alive.png"),
                    const SizedBox(height: 20),
                    Text(
                      "En este apartado se le dara una introduccion al ministerio de alive",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
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
