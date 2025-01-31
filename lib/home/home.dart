import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../pantallas/eventos.dart';
import '../pantallas/iglesia.dart';
import '../pantallas/ministerios.dart';
import '../pantallas/ofrendas.dart';
import '../pantallas/transmisiones.dart';
import 'constantes.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final screens = const [
      Eventos(),
      Transmisiones(),
      Iglesia(),
      Ministerios(),
      Ofrendas(),
    ];

    return Scaffold(
      backgroundColor: negro,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GNav(
          tabBackgroundColor: blanco,
          color: blanco,
          selectedIndex: currentIndex,
          tabBorderRadius: 100,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          onTabChange: (index) => ref.read(currentIndexProvider.notifier).state = index,
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
