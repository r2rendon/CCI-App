import 'package:flutter/material.dart';
import 'inicio.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/home_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.7),
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.6),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Top section with location
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.1),
                        Text(
                          "San Pedro Sula",
                          style: TextStyle(
                            color: const Color(0xFFF5F5DC), // Light beige color
                            fontSize: screenWidth < 360 ? 28 : 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        // Logo with transparency
                        Container(
                          width: screenWidth * 0.4,
                          height: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.25,
                              color: Colors.white.withValues(alpha: 0.8),
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.church,
                                  size: screenWidth * 0.2,
                                  color: Colors.white.withValues(alpha: 0.8),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom section with welcome card
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C), // Dark grey
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.08),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Welcome text
                          Text(
                            "Bienvenido a CCI",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth < 360 ? 24 : 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            "Móvil",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth < 360 ? 24 : 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),

                          // Start button
                          _buildStartButton(context, screenWidth, screenHeight),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton(
      BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.06,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const Inicio()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F5DC), // Light beige
          foregroundColor: const Color(0xFF2C2C2C), // Dark grey
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Empezar",
              style: TextStyle(
                fontSize: screenWidth < 360 ? 16 : 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Container(
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: const Color(0xFFF5F5DC),
                size: screenWidth * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
