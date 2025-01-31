import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class Mapa extends ConsumerWidget {
  final String mapa;
  const Mapa(this.mapa, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = 'https://maps.app.goo.gl/dxPGGHJEZFQPBgJt8';
    return InkWell(
      onTap: () => _launchMaps(context, url),
      child: Tooltip(
        message: 'Ubicación: $mapa',
        child: const Text(
          'Ver ubicación',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _launchMaps(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se puede abrir Maps';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir Maps')),
        );
      }
    }
  }
}
