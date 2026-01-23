import 'package:cci_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Telefono extends StatelessWidget {
  final String celular;
  const Telefono(this.celular, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _launchURL(context),
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
                message: 'Teléfono: $celular',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: accent,
                      size: screenWidth < 360 ? 18 : 20,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      '+504 2510-1731',
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
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No se pudo realizar la llamada'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
