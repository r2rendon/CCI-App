import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneProvider = Provider<String>((ref) => '31750015');

class WhatsApp extends ConsumerWidget {
  final String mapa;
  const WhatsApp(this.mapa, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneProvider);
    return InkWell(
      onTap: () => _launchWhatsApp(context, phoneNumber),
      child: Tooltip(
        message: 'WhatsApp: $mapa',
        child: const Text(
          'Acompañamiento Espiritual',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp(BuildContext context, String number) async {
    final url =
        'https://api.whatsapp.com/send/?phone=$number&text&type=phone_number&app_absent=0';
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
