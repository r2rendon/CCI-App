import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsApp extends StatelessWidget {
  final String mapa;
  const WhatsApp(this.mapa, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: _launchWhatsApp,
            child: Container(
              child: Tooltip(
                message: 'WhatsApp: $mapa',
                child: const Text(
                  'Acompañamiento Espiritual',
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

  Future<void> _launchWhatsApp() async {
    const phoneNumber = '31750015';
    const url = 'https://api.whatsapp.com/send/?phone=$phoneNumber&text&type=phone_number&app_absent=0';
    final uri = Uri.parse(url);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se puede abrir WhatsApp';
      }
    } catch (e) {
      debugPrint('Error al abrir WhatsApp: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir WhatsApp')),
        );
      }
    }
  }
}
