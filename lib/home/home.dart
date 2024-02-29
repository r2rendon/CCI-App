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

// import 'package:flutter/material.dart';
// import '../pantallas/eventos.dart';
// import '../pantallas/iglesia.dart';
// import '../pantallas/ministerios.dart';
// import '../pantallas/ofrendas.dart';
// import '../pantallas/transmisiones.dart';
// import 'constantes.dart';

// class Home extends StatefulWidget {
//   @override
//   State<Home> createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   get child => null;

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: negro,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 2,
//             child: Image.asset(
//               "assets/images/mundo.jpg",
//             ),
//           ),

//           //Transmisiones en vivo
//           Positioned(
//             top: 90,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.videocam_outlined,
//                   color: blanco,
//                   size: 25,
//                 ),
//                 const SizedBox(width: 10),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     textStyle: TextStyle(
//                       color: blanco,
//                       fontSize: 25,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Transmisiones(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Transmisiones en vivo',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       color: blanco,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           //Eventos
//           Positioned(
//             top: 150,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.groups_2_outlined,
//                   color: blanco,
//                   size: 25,
//                 ),
//                 const SizedBox(width: 10),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     textStyle: TextStyle(
//                       fontSize: 25,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Eventos(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Eventos',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       color: blanco,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           //Ofrendas
//           Positioned(
//             top: 209.9,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.mobile_friendly,
//                   color: blanco,
//                   size: 25,
//                 ),
//                 const SizedBox(width: 10),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     textStyle: TextStyle(
//                       fontSize: 25,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Ofrendas(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Dar',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       color: blanco,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           //Iglesia
//           Positioned(
//             top: 270.9,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.church_outlined,
//                   color: blanco,
//                   size: 25,
//                 ),
//                 const SizedBox(width: 10),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     textStyle: TextStyle(
//                       fontSize: 25,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Iglesia(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Nuestra Iglesia',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       color: blanco,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           //Ministerios
//           Positioned(
//             top: 335,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.person_3,
//                   color: blanco,
//                   size: 25,
//                 ),
//                 const SizedBox(width: 10),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     textStyle: TextStyle(
//                       color: blanco,
//                       fontSize: 25,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Ministerios(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Ministerios',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       color: blanco,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
