import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/constantes.dart';

class Mapa extends StatelessWidget {
  final String mapa;
  const Mapa(this.mapa, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchMaps(context),
      child: Tooltip(
        message: 'Ubicación: $mapa',
        child: const Text(
          'Ver ubicación',
          textAlign: TextAlign.center,
          style: TextStyle(color: blanco),
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
          const SnackBar(content: Text('No se pudo abrir Maps')),
        );
      }
    }
  }
}
