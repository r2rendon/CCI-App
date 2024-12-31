// import 'package:cci_app/home/constantes.dart';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Externa extends StatelessWidget {
  final String actividad;
  const Externa(this.actividad, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: _launchURL,
            child: Container(
              child: Tooltip(
                message: 'Mapa: $actividad',
                child: Text(
                  'Kilo Bistro, GXP5+PFC, 21102 San Pedro Sula, Cortés, Honduras.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: blanco,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL() async {
    const url = 'https://www.google.com/maps/place/Kilo+Bistro/@15.5368038,-88.0413544,17z/data=!3m1!4b1!4m6!3m5!1s0x8f665b414c15ac45:0xc6f3e6b4517ae5df!8m2!3d15.5368038!4d-88.0413544!16s%2Fg%2F11s9whqklr?entry=ttu';
    final uri = Uri.parse(url);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se puede abrir $url';
      }
    } catch (e) {
      debugPrint('Error al abrir URL: $e');
      // Aquí podrías mostrar un SnackBar o AlertDialog
    }
  }
}
