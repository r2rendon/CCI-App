import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/constantes.dart';

class Mapa extends StatelessWidget {
  final String mapa;
  const Mapa(this.mapa, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => _launchMaps(context),
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.02,
        ),
        decoration: BoxDecoration(
          color: colorWithOpacity(const Color(0xFF4285F4), 0.2),
          borderRadius: BorderRadius.circular(borderRadius),
          border:
              Border.all(color: colorWithOpacity(const Color(0xFF4285F4), 0.5)),
          boxShadow: defaultShadow,
        ),
        child: Tooltip(
          message: 'Ubicación: $mapa',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: const Color(0xFF4285F4),
                size: screenWidth < 360 ? 18 : 20,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                'Ver ubicación',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blanco,
                  fontSize: screenWidth < 360 ? 14 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchMaps(BuildContext context) async {
    const url = 'https://maps.app.goo.gl/dxPGGHJEZFQPBgJt8';
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se puede abrir Maps';
      }
    } catch (e) {
      debugPrint('Error al abrir Maps: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No se pudo abrir Maps'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
