import 'package:cci_app/home/constantes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../pantallas/eventos.dart';
import '../pantallas/iglesia.dart';
import '../pantallas/ministerios.dart';
import '../pantallas/ofrendas.dart';
import '../pantallas/transmisiones.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  final screens = const [
    Eventos(),
    Transmisiones(),
    Iglesia(),
    Ministerios(),
    Ofrendas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GNav(
          tabBackgroundColor: blanco,
          color: blanco,
          selectedIndex: _currentIndex,
          tabBorderRadius: 100,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.groups_2_outlined,
              backgroundColor: barr,
              rippleColor: blanco,
              padding: EdgeInsets.all(15.0),
              iconActiveColor: blanco,
            ),
            GButton(
              icon: Icons.videocam_outlined,
              backgroundColor: barr,
              padding: EdgeInsets.all(15.0),
              iconActiveColor: negro,
            ),
            GButton(
              icon: Icons.church_outlined,
              backgroundColor: barr,
              rippleColor: blanco,
              padding: EdgeInsets.all(15.0),
              iconActiveColor: blanco,
            ),
            GButton(
              icon: Icons.person_3,
              backgroundColor: barr,
              rippleColor: blanco,
              padding: EdgeInsets.all(15.0),
              iconActiveColor: blanco,
            ),
            GButton(
              icon: Icons.mobile_friendly,
              backgroundColor: barr,
              rippleColor: blanco,
              padding: EdgeInsets.all(15.0),
              iconActiveColor: blanco,
            ),
          ],
        ),
      ),
    );
  }
}
