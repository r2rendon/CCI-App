import 'package:flutter/material.dart';
import '../home/constantes.dart';
import 'eventos.dart';
import 'iglesia.dart';
import 'ministerios.dart';
import 'transmisiones.dart';
import 'ofrendas.dart';
import 'next.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    print('Inicio: initState');
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Inicio: build');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/menu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.6),
                Colors.black.withValues(alpha: 0.4),
                Colors.black.withValues(alpha: 0.7),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getHorizontalPadding(screenWidth),
                        vertical: getVerticalPadding(screenWidth),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header section
                          _buildHeader(screenWidth, screenHeight),

                          SizedBox(height: screenHeight * 0.04),

                          // Menu title
                          _buildMenuTitle(screenWidth),

                          SizedBox(height: screenHeight * 0.03),

                          // Menu buttons grid
                          Expanded(
                            child: _buildMenuGrid(screenWidth, screenHeight),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hola Familia",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth < 360 ? 18 : 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        Text(
          "San Pedro Sula",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth < 360 ? 24 : 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTitle(double screenWidth) {
    return Text(
      "Menú",
      style: TextStyle(
        color: Colors.white,
        fontSize: screenWidth < 360 ? 20 : 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildMenuGrid(double screenWidth, double screenHeight) {
    return Column(
      children: [
        // First row - Eventos (wide button)
        _buildEventosButton(screenWidth, screenHeight),

        SizedBox(height: screenHeight * 0.02),

        // Second row - Seamos Iglesia and Ministerios CCI
        Row(
          children: [
            Expanded(
              child: _buildSeamosIglesiaButton(screenWidth, screenHeight),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: _buildMinisteriosButton(screenWidth, screenHeight),
            ),
          ],
        ),

        SizedBox(height: screenHeight * 0.02),

        // Third row - En vivo (wide button)
        _buildEnVivoButton(screenWidth, screenHeight),

        SizedBox(height: screenHeight * 0.02),

        // Fourth row - Dar and Next
        Row(
          children: [
            Expanded(
              child: _buildDarButton(screenWidth, screenHeight),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: _buildNextButton(screenWidth, screenHeight),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEventosButton(double screenWidth, double screenHeight) {
    return _buildMenuButton(
      icon: Icons.calendar_today,
      text: "Eventos",
      onTap: () => _navigateToScreen(const Eventos()),
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      isWide: true,
    );
  }

  Widget _buildSeamosIglesiaButton(double screenWidth, double screenHeight) {
    return _buildMenuButton(
      icon: Icons.church,
      text: "Seamos Iglesia",
      onTap: () => _navigateToScreen(const Iglesia()),
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      isWide: false,
    );
  }

  Widget _buildMinisteriosButton(double screenWidth, double screenHeight) {
    return _buildMenuButton(
      icon: Icons.people,
      text: "Ministerios CCI",
      onTap: () => _navigateToScreen(const Ministerios()),
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      isWide: false,
    );
  }

  Widget _buildEnVivoButton(double screenWidth, double screenHeight) {
    return _buildMenuButton(
      icon: Icons.live_tv,
      text: "En vivo",
      onTap: () => _navigateToScreen(const Transmisiones()),
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      isWide: true,
    );
  }

  Widget _buildDarButton(double screenWidth, double screenHeight) {
    return _buildMenuButton(
      icon: Icons.mail_outline,
      text: "Dar",
      onTap: () => _navigateToScreen(const Ofrendas()),
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      isWide: false,
    );
  }

  Widget _buildNextButton(double screenWidth, double screenHeight) {
    return _buildMenuButton(
      icon: Icons.arrow_forward,
      text: "Next",
      onTap: () => _navigateToScreen(const Next()),
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      isWide: false,
      customIcon: _buildNextIcon(screenWidth),
    );
  }

  Widget _buildNextIcon(double screenWidth) {
    return Container(
      width: screenWidth * 0.12,
      height: screenWidth * 0.12,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          "NEXT",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.025,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required double screenWidth,
    required double screenHeight,
    required bool isWide,
    Widget? customIcon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: isWide ? screenHeight * 0.12 : screenHeight * 0.14,
        decoration: BoxDecoration(
          color: beigeClaro,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            if (customIcon != null)
              customIcon
            else
              Icon(
                icon,
                size: isWide ? screenWidth * 0.08 : screenWidth * 0.1,
                color: grisOscuro,
              ),

            SizedBox(height: screenHeight * 0.01),

            // Text
            Text(
              text,
              style: TextStyle(
                color: grisOscuro,
                fontSize: isWide ? screenWidth * 0.04 : screenWidth * 0.035,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
