import 'package:flutter/material.dart';
import '../widgets/ministry_screen_base.dart';
import '../redes sociales/ig_alive.dart';

class Alive extends StatelessWidget {
  const Alive({super.key});

  @override
  Widget build(BuildContext context) {
    return MinistryScreenBase(
      title: "Alive",
      description:
          "Alive es nuestro ministerio enfocado en jóvenes y adultos jóvenes. "
          "Un espacio dinámico donde puedes crecer en tu fe mientras te conectas "
          "con otros y descubres tu propósito en Cristo.",
      imagePath: "assets/images/alive.png",
      additionalInfo:
          "Únete a Alive y sé parte de una comunidad vibrante que busca vivir "
          "una vida plena en Cristo. Tenemos reuniones semanales, eventos especiales "
          "y espacios de crecimiento diseñados para jóvenes adultos.",
      socialWidget: const IgAlive('Instagram'),
    );
  }
}

