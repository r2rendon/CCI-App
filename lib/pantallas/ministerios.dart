import 'package:cci_app/Informacion/produccion.dart';
import 'package:cci_app/redes%20sociales/fb_hombres.dart';
import 'package:cci_app/redes%20sociales/ig_matrimonios.dart';
import 'package:cci_app/redes%20sociales/ig_mujeres.dart';
import 'package:cci_app/redes%20sociales/ig_next.dart';
import 'package:cci_app/redes%20sociales/ig_shift.dart';
import 'package:flutter/material.dart';
import '../Informacion/Worship.dart';
import '../home/constantes.dart';
import '../redes sociales/ig_alive.dart';

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
              const SizedBox(height: 45),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Container(
                      child: Image.asset("assets/images/alabanza.png"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blanco,
                        ),
                        child: Text(
                          "Forma parte de nuestro equipo!",
                          style: TextStyle(
                            color: negro,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormProduccion(),
                            ),
                          );
                        },
                        child: Text(
                          "Forma parte de nuestro equipo!",
                          style: TextStyle(
                            color: negro,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IgAlive('Instagram'),
                      ],
                    ),
                  ],
                ),
              ),
              //Apartado de next
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/next.png"),
                    const SizedBox(height: 20),
                    Text(
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IgNext('Instagram'),
                      ],
                    ),
                  ],
                ),
              ),
              //Apartado de shift
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/shift.png"),
                    const SizedBox(height: 20),
                    Text(
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IgShift('Instagram'),
                      ],
                    ),
                  ],
                ),
              ),
              //Apartado de hombres
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/hombres.png"),
                    const SizedBox(height: 20),
                    Text(
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FbHombres('Facebook'),
                      ],
                    ),
                  ],
                ),
              ),
              //Apartado de mujeres
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/mujeres.png"),
                    const SizedBox(height: 20),
                    Text(
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IgMujeres('Instagram'),
                      ],
                    ),
                  ],
                ),
              ),
              //Apartado de matrimonios
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/matrimonios.png"),
                    const SizedBox(height: 20),
                    Text(
                      "Ser un ministerio entendido de nuestra función como siervos que disciernen la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es Él y lo que ha hecho por nosotros.",
                      style: TextStyle(
                        color: blanco,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IgMatrimonios('Instagram'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
