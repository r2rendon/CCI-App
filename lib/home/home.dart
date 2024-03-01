import 'package:cci_app/home/constantes.dart';

import 'package:cci_app/pantallas/ofrendas.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../pantallas/eventos.dart';
import '../pantallas/iglesia.dart';
import '../pantallas/ministerios.dart';
import '../pantallas/transmisiones.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  final screens = [
    Eventos(),
    Transmisiones(),
    Iglesia(),
    Ministerios(),
    Ofrendas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GNav(
          tabBackgroundColor: negro,
          selectedIndex: _currentIndex,
          tabBorderRadius: 100,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          onTabChange: (index) => {setState(() => _currentIndex = index)},
          tabs: const [
            GButton(
              icon: Icons.groups_2_outlined,
              text: ' Eventos',
              iconActiveColor: blanco,
              textColor: blanco,
            ),
            GButton(
              icon: Icons.videocam_outlined,
              text: 'Transmisiones',
              iconActiveColor: blanco,
              textColor: blanco,
            ),
            GButton(
              icon: Icons.church_outlined,
              text: 'Iglesia',
              iconActiveColor: blanco,
              textColor: blanco,
            ),
            GButton(
              icon: Icons.person_3,
              text: 'Ministerios',
              iconActiveColor: blanco,
              textColor: blanco,
            ),
            GButton(
              icon: Icons.mobile_friendly,
              text: 'Ofrendas',
              iconActiveColor: blanco,
              textColor: blanco,
            ),
          ],
        ),
      ),
    );
  }
}
