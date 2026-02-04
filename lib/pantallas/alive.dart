import 'package:flutter/material.dart';
import '../widgets/ministry_screen_base.dart';
import '../widgets/ministry_events_section.dart';
import '../redes sociales/ig_alive.dart';

class Alive extends StatelessWidget {
  const Alive({super.key});

  @override
  Widget build(BuildContext context) {
    return MinistryScreenBase(
      title: "Alive",
      description:
          "Somos una familia de jovenes enfocados en la restauración "
          "integral de nuestros adolescentes y en su formación para alcanzar ",
      imagePath: "assets/images/alive.png",
      additionalInfo:
          "Únete a Alive y sé parte de una comunidad vibrante que busca vivir "
          "una vida plena en Cristo. Tenemos reuniones semanales"
          "y espacios de crecimiento diseñados para jóvenes.",
      socialWidget: const IgAlive('Instagram'),
      informationSection: const MinistryEventsSection(category: 'alive'),
    );
  }
}


