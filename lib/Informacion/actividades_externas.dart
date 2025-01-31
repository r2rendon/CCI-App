import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cci_app/home/constantes.dart';

class Externa extends ConsumerWidget {
  final String actividad;
  const Externa(this.actividad, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url =   'https://www.google.com/maps/place/Kilo+Bistro/@15.5368038,-88.0413544,17z/data=!3m1!4b1!4m6!3m5!1s0x8f665b414c15ac45:0xc6f3e6b4517ae5df!8m2!3d15.5368038!4d-88.0413544!16s%2Fg%2F11s9whqklr?entry=ttu';
    return Column(
      children: [
        InkWell(
          onTap: () => _launchURL(url),
          child: Tooltip(
            message: 'Mapa: $actividad',
            child: const Text(
              'Kilo Bistro, GXP5+PFC, 21102 San Pedro Sula, Cortés, Honduras.',
              textAlign: TextAlign.center,
              style: TextStyle(color: blanco),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
