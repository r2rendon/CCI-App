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
  bool _isLoading = false;

  final screens = const [
    Eventos(),
    Transmisiones(),
    Iglesia(),
    Ministerios(),
    Ofrendas(),
  ];

  @override
  Widget build(BuildContext context) {
    print('Home: build');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: negro,
      body: SafeArea(
        child: Stack(
          children: [
            screens[_currentIndex],
            if (_isLoading)
              Container(
                color: colorWithOpacity(negro, 0.7),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: blanco,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: negro,
          boxShadow: defaultShadow,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getHorizontalPadding(screenWidth) * 0.3,
              vertical: 10,
            ),
            child: GNav(
              tabBackgroundColor: blanco,
              color: blanco,
              selectedIndex: _currentIndex,
              tabBorderRadius: borderRadius,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.015,
                horizontal: screenWidth * 0.02,
              ),
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: [
                GButton(
                  icon: Icons.groups_2_outlined,
                  backgroundColor: barr,
                  rippleColor: blanco,
                  padding: EdgeInsets.all(screenWidth * 0.035),
                  iconActiveColor: negro,
                  iconColor: blanco,
                  textColor: negro,
                  text: screenWidth > 600 ? 'Eventos' : '',
                ),
                GButton(
                  icon: Icons.videocam_outlined,
                  backgroundColor: barr,
                  rippleColor: blanco,
                  padding: EdgeInsets.all(screenWidth * 0.035),
                  iconActiveColor: negro,
                  iconColor: blanco,
                  textColor: negro,
                  text: screenWidth > 600 ? 'En Vivo' : '',
                ),
                GButton(
                  icon: Icons.church_outlined,
                  backgroundColor: barr,
                  rippleColor: blanco,
                  padding: EdgeInsets.all(screenWidth * 0.035),
                  iconActiveColor: negro,
                  iconColor: blanco,
                  textColor: negro,
                  text: screenWidth > 600 ? 'Iglesia' : '',
                ),
                GButton(
                  icon: Icons.person_3,
                  backgroundColor: barr,
                  rippleColor: blanco,
                  padding: EdgeInsets.all(screenWidth * 0.035),
                  iconActiveColor: negro,
                  iconColor: blanco,
                  textColor: negro,
                  text: screenWidth > 600 ? 'Ministerios' : '',
                ),
                GButton(
                  icon: Icons.mobile_friendly,
                  backgroundColor: barr,
                  rippleColor: blanco,
                  padding: EdgeInsets.all(screenWidth * 0.035),
                  iconActiveColor: negro,
                  iconColor: blanco,
                  textColor: negro,
                  text: screenWidth > 600 ? 'Dar' : '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
