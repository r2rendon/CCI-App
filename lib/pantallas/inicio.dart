import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import '../home/home.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Decorations,
      child: Center(
        child: IconButton(
          icon: Image.asset('assets/images/logo.png'),
          iconSize: 50,
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Home(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(
        0.0,
        1.0,
      );
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(
        begin: begin,
        end: end,
      ).chain(
        CurveTween(
          curve: curve,
        ),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
