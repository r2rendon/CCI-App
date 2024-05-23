import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Telefono extends StatelessWidget {
  String celular;
  Telefono(this.celular);

  @override
  Widget build(BuildContext context) {
    final barraiconos = Container(
      child: Column(
        children: [
          InkWell(
            child: Container(
              child: Tooltip(
                child: Text(
                  '+504 2510-1731',
                  style: TextStyle(color: blanco),
                ),
                message: 'Celular: ' + celular.toString(),
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
    // const url = 'tel:+504 2510 1731';
    final telUri = Uri(
      scheme: 'tel',
      path: '+504 2510 1731',
    );
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $telUri';
    }
  }
}
