// import 'package:cci_app/home/constantes.dart';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Externa extends StatelessWidget {
  String mapa;
  Externa(this.mapa);

  @override
  Widget build(BuildContext context) {
    final barraiconos = Container(
      child: Column(
        children: [
          InkWell(
            child: Container(
              child: Tooltip(
                child: Text(
                  'Kilo Bistro, GXP5+PFC, 21102 San Pedro Sula, Cortés, Honduras.',
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
        'https://www.google.com/maps/place/Kilo+Bistro/@15.5368038,-88.0413544,17z/data=!3m1!4b1!4m6!3m5!1s0x8f665b414c15ac45:0xc6f3e6b4517ae5df!8m2!3d15.5368038!4d-88.0413544!16s%2Fg%2F11s9whqklr?entry=ttu';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se puede abrir $url';
    }
  }
}
