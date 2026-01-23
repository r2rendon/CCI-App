import 'package:flutter/material.dart';
import '../widgets/ministry_screen_base.dart';
import '../redes sociales/ig_shift.dart';

class Shift extends StatelessWidget {
  const Shift({super.key});

  @override
  Widget build(BuildContext context) {
    return MinistryScreenBase(
      title: "Shift",
      description:
          "Shift es un ministerio dinámico enfocado en el crecimiento y desarrollo "
          "de la próxima generación. Proporcionamos un espacio donde los jóvenes pueden "
          "conectarse, crecer espiritualmente y hacer un impacto positivo en su comunidad.",
      imagePath: "assets/images/shift.png",
      additionalInfo:
          "Únete a Shift y sé parte de un ministerio que busca transformar vidas "
          "y comunidades. Tenemos reuniones semanales, eventos especiales y espacios "
          "de crecimiento diseñados para jóvenes que desean hacer una diferencia.",
      socialWidget: const IgShift('Instagram'),
    );
  }
}

