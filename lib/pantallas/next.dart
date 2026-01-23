import 'package:flutter/material.dart';
import '../widgets/ministry_screen_base.dart';
import '../redes sociales/ig_next.dart';

class Next extends StatelessWidget {
  const Next({super.key});

  @override
  Widget build(BuildContext context) {
    return MinistryScreenBase(
      title: "Next Generation",
      description:
          "Next Generation es nuestro ministerio enfocado en los jóvenes y adolescentes. "
          "Creemos en el potencial de la próxima generación para impactar el mundo con el amor de Cristo.",
      imagePath: "assets/images/next.png",
      additionalInfo:
          "Únete a Next Generation y sé parte de una comunidad que busca crecer "
          "espiritualmente mientras se divierte y forma amistades duraderas. "
          "Tenemos actividades, estudios bíblicos y eventos especiales diseñados "
          "específicamente para jóvenes como tú.",
      socialWidget: const IgNext('Instagram'),
    );
  }
}
