import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class Telefono extends ConsumerWidget {
  final String celular;
  const Telefono(this.celular, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: _launchURL,
            child: Container(
              child: Tooltip(
                message: 'Teléfono: $celular',
                child: const Text(
                  '+504 2510-1731',
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
    final telUri = Uri(
      scheme: 'tel',
      path: '+504 2510 1731',
    );
    
    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        throw 'No se puede realizar la llamada';
      }
    } catch (e) {
      debugPrint('Error al realizar llamada: $e');
      // Aquí podrías mostrar un SnackBar o AlertDialog
    }
  }
}
