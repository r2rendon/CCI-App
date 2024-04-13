// import 'package:cci_app/home/constantes.dart';
import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class IgShift extends StatelessWidget {
  String ig;
  IgShift(this.ig);

  @override
  Widget build(BuildContext context) {
    final barraiconos = Container(
      child: Column(
        children: [
          InkWell(
            child: Container(
              child: Tooltip(
                child: Text(
                  'Conoce más de nosotros!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blanco,
                  ),
                ),
                message: 'Instagram: ' + ig.toString(),
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
        'https://www.instagram.com/shiftcci_?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se puede abrir $url';
    }
  }
}
