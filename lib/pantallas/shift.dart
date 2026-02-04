import 'package:flutter/material.dart';
import '../widgets/ministry_screen_base.dart';
import '../widgets/ministry_events_section.dart';
import '../redes sociales/ig_shift.dart';

class Shift extends StatelessWidget {
  const Shift({super.key});

  @override
  Widget build(BuildContext context) {
    return MinistryScreenBase(
      title: "Shift",
      description:
          "Queremos ser un oasis en el desierto para los adultos jóvenes de nuestra iglesia: "
          "un lugar donde encuentren el agua viva que quita toda sed, el alimento espiritual "
          "solido que los hace crecer y madurar, y el descanso y la paz que solo el Espíritu "
          "Santo puede dar.",
      imagePath: "assets/images/shift.png",
      additionalInfo:
          "Únete a Shift y sé parte de un ministerio que busca transformar vidas "
          "y comunidades. Tenemos reuniones mensuales y espacios "
          "de crecimiento diseñados para jóvenes adultos que desean hacer una diferencia.",
      socialWidget: const IgShift('Instagram'),
      informationSection: const MinistryEventsSection(category: 'shift'),
    );
  }
}

