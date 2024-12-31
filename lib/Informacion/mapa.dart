import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Mapa extends StatelessWidget {
  final String mapa;
  const Mapa(this.mapa, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: _launchURL,
            child: Container(
              child: Tooltip(
                message: 'Mapa: $mapa',
                child: const Text(
                  'Honduras, San Pedro Sula, Colonia Trejo 9 calle, 21 y 22 avenida.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
    const url = 'https://www.google.com/maps/dir//21+Avenida+C,+21104+San+Pedro+Sula,+Cort%C3%A9s/@15.4993824,-88.1253334,12z/data=!4m8!4m7!1m0!1m5!1m1!1s0x8f665b7b12ee24a5:0xe328a49b963cfcbb!2m2!1d-88.0429316!2d15.4993977?entry=ttu';
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
          const SnackBar(content: Text('No se pudo abrir el mapa')),
        );
      }
    }
  }
}
