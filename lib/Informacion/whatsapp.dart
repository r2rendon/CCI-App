import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class WhatsApp extends StatelessWidget {
  String mapa;
  WhatsApp(this.mapa);

  @override
  Widget build(BuildContext context) {
    final barraiconos = Container(
      child: Column(
        children: [
          InkWell(
            child: Container(
              child: Tooltip(
                child: Text(
                  'Acompañamiento Espiritual',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blanco,
                  ),
                ),
                message: 'Mapa: ' + mapa.toString(),
              ),
            ),
            onTap: () {
              _launchURL();
            },
          ),
        ],
      ),
    );
    return barraiconos;
  }

  _launchURL() async {
    const url =
        'https://api.whatsapp.com/send/?phone=31750015&text&type=phone_number&app_absent=0';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se puede abrir $url';
    }
  }
}
