import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/constantes.dart';

class SocialLink extends StatelessWidget {
  final String socialId;
  final String url;
  final String platform;

  const SocialLink({
    required this.socialId,
    required this.url,
    required this.platform,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _launchURL(context),
        borderRadius: BorderRadius.circular(8.0),
        child: Tooltip(
          message: '$platform: $socialId',
          child: const Text(
            'Conoce más de nosotros!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blanco,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final uri = Uri.parse(url);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'No se puede abrir $platform';
      }
    } catch (e) {
      debugPrint('Error al abrir $platform: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir $platform'),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}