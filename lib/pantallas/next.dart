import 'package:flutter/material.dart';
import '../widgets/ministry_screen_base.dart';
import '../widgets/ministry_events_section.dart';
import '../redes sociales/ig_next.dart';

class Next extends StatelessWidget {
  const Next({super.key});

  @override
  Widget build(BuildContext context) {
    return MinistryScreenBase(
      title: "Next",
      description:
          "Somos una familia de jovenes enfocados en formar jóvenes que vivan con Dios "
          "cada día y reflejen al Espíritu Santo. Guiándolos a descubrir su identidad y "
          "propósito en Jesús, crecer espiritualmente, construir relaciones sanas y servir "
          "activamente en la misión de la iglesia.",
      imagePath: "assets/images/next.png",
      additionalInfo:
          "Únete a Next y sé parte de una comunidad que busca crecer "
          "espiritualmente mientras se divierte y forma amistades duraderas. "
          "Tenemos actividades, estudios bíblicos y eventos especiales diseñados "
          "específicamente para jóvenes como tú.",
      socialWidget: const IgNext('Instagram'),
      informationSection: const MinistryEventsSection(category: 'next'),
    );
  }
}
