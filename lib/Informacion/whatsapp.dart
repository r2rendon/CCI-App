import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/constantes.dart';

class WhatsApp extends StatelessWidget {
  final String mapa;
  const WhatsApp(this.mapa, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _launchWhatsApp(context),
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.02,
        ),
        decoration: BoxDecoration(
          color: grisCard,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: colorWithOpacity(blanco, 0.1),
            width: 0.5,
          ),
        ),
        child: Tooltip(
          message: 'WhatsApp: $mapa',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_outlined,
                color: const Color(0xFF25D366),
                size: screenWidth < 360 ? 18 : 20,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                'Acompañamiento Espiritual',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: blanco,
                  fontSize: screenWidth < 360 ? 15 : 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.41,
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp(BuildContext context) async {
    const phoneNumber = '31750015';
    const url =
        'https://api.whatsapp.com/send/?phone=$phoneNumber&text&type=phone_number&app_absent=0';
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
          SnackBar(
            content: const Text('No se pudo abrir WhatsApp'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
