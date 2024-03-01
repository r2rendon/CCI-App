
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
