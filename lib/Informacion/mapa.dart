// import 'package:cci_app/home/constantes.dart';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Mapa extends StatelessWidget {
  String mapa;
  Mapa(this.mapa);

  @override
  Widget build(BuildContext context) {
    final barraiconos = Container(
      child: Column(
        children: [
          InkWell(
            child: Container(
              child: Tooltip(
                child: Text(
                  'Honduras, San Pedro Sula, Colonia Trejo 9 calle, 21 y 22 avenida.',
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
        'https://www.google.com/maps/dir//21+Avenida+C,+21104+San+Pedro+Sula,+Cort%C3%A9s/@15.4993824,-88.1253334,12z/data=!4m8!4m7!1m0!1m5!1m1!1s0x8f665b7b12ee24a5:0xe328a49b963cfcbb!2m2!1d-88.0429316!2d15.4993977?entry=ttu';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se puede abrir $url';
    }
  }
}
