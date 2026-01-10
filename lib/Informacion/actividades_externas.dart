// import 'package:cci_app/home/constantes.dart';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadesExternas extends StatelessWidget {
  const ActividadesExternas({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Externa('Facebook'),
        SizedBox(height: screenWidth * 0.02),
        Externa('Instagram'),
        SizedBox(height: screenWidth * 0.02),
        Externa('YouTube'),
      ],
    );
  }
}

class Externa extends StatelessWidget {
  final String actividad;
  const Externa(this.actividad, {super.key});

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
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.03,
              ),
              decoration: BoxDecoration(
                color: colorWithOpacity(blanco, 0.05),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: colorWithOpacity(blanco, 0.1),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getPlatformIcon(actividad),
                    color: blanco,
                    size: screenWidth < 360 ? 18 : 20,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Síguenos en $actividad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: blanco,
                      fontSize: screenWidth < 360 ? 14 : 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.0,
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

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return Icons.camera_alt;
      case 'facebook':
        return Icons.facebook;
      case 'youtube':
        return Icons.play_circle;
      case 'whatsapp':
        return Icons.chat;
      default:
        return Icons.link;
    }
  }

  Future<void> _launchURL(BuildContext context) async {
    String url = '';
    switch (actividad.toLowerCase()) {
      case 'facebook':
        url = 'https://facebook.com/ccisanpedrosula';
        break;
      case 'instagram':
        url = 'https://instagram.com/ccisanpedrosula';
        break;
      case 'youtube':
        url = 'https://youtube.com/ccisanpedrosula';
        break;
      default:
        url = 'https://ccisanpedrosula.com';
    }

    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'No se puede abrir $actividad';
      }
    } catch (e) {
      debugPrint('Error al abrir $actividad: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir $actividad'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
