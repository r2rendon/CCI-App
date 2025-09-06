// import 'package:cci_app/home/constantes.dart';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Externa extends StatelessWidget {
  final String actividad;
  const Externa(this.actividad, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => _launchURL(context),
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenWidth * 0.01,
              ),
              decoration: BoxDecoration(
                color: colorWithOpacity(blanco, 0.1),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: colorWithOpacity(blanco, 0.3)),
              ),
              child: Tooltip(
                message: 'Mapa: $actividad',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: blanco,
                      size: screenWidth < 360 ? 16 : 18,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        'Kilo Bistro, GXP5+PFC, 21102 San Pedro Sula, Cortés, Honduras.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blanco,
                          fontSize: screenWidth < 360 ? 12 : 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    const url =
        'https://www.google.com/maps/place/Kilo+Bistro/@15.5368038,-88.0413544,17z/data=!3m1!4b1!4m6!3m5!1s0x8f665b414c15ac45:0xc6f3e6b4517ae5df!8m2!3d15.5368038!4d-88.0413544!16s%2Fg%2F11s9whqklr?entry=ttu';
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se puede abrir $url';
      }
    } catch (e) {
      debugPrint('Error al abrir URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No se pudo abrir el mapa'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
