import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/constantes.dart';
import '../home/home.dart';

class Inicio extends ConsumerWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: decorations,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(context),
            const SizedBox(height: 20),
            _buildTapImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Image.asset('assets/images/logo.png'),
        iconSize: 150,
        onPressed: () => _navigateToHome(context),
      ),
    );
  }

  Widget _buildTapImage() {
    return Image.asset(
      'assets/images/tap.png',
      scale: 1,
      height: 100,
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      _createRoute(),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Home(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}
