import 'package:flutter/material.dart';
import '../pantallas/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('SplashScreen: initState');
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        print('SplashScreen: Navegando a WelcomeScreen');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('SplashScreen: build');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: screenWidth * 0.5,
          height: screenHeight * 0.3,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 100, color: Colors.red);
          },
        ),
      ),
    );
  }
}
