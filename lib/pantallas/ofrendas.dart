import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Ofrendas extends StatelessWidget {
  const Ofrendas({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: negro,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: decorations,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                _buildHeader(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),
                _buildLocation(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildDescription(screenWidth),
                _buildBiblicalQuote(screenWidth),
                _buildBankAccounts(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getHorizontalPadding(screenWidth),
        vertical: getVerticalPadding(screenWidth),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Dar",
              style: getTitulo(screenWidth),
            ),
          ),
          Image.asset(
            "assets/images/logo.png",
            height: screenHeight * 0.05,
            color: blanco,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.favorite,
                size: screenHeight * 0.05,
                color: blanco,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocation(double screenWidth) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getHorizontalPadding(screenWidth)),
      child: Text(
        "San Pedro Sula",
        style: TextStyle(
          color: blanco,
          fontSize: screenWidth < 360 ? 14 : 16,
        ),
      ),
    );
  }

  Widget _buildDescription(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Text(
        "Hemos dispuesto nuestras cuentas bancarias para que puedas dar tus diezmos y ofrendas",
        style: TextStyle(
          fontSize: screenWidth < 360 ? 16 : 18,
          height: 1.5,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildBiblicalQuote(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenWidth * 0.05),
          Divider(color: gris),
          Text(
            "Proverbios 3:9-10",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blanco,
              fontSize: screenWidth < 360 ? 18 : 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            'Honra al Señor con tus riquezas y con lo mejor de todo lo que produces. '
            'Entonces él llenará tus graneros, y tus tinajas se desbordarán de buen vino.',
            style: TextStyle(
              fontSize: screenWidth < 360 ? 14 : 15,
              fontStyle: FontStyle.italic,
              color: blanco,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth * 0.05),
          Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildBankAccounts(double screenWidth, double screenHeight) {
    return Column(
      children: [
        _buildBankCard("bac", screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),
        _buildBankCard("atlantida", screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),
        Divider(color: gris),
      ],
    );
  }

  Widget _buildBankCard(
      String bankName, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      decoration: BoxDecoration(
        color: const Color.fromARGB(20, 255, 255, 255),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: defaultShadow,
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Image.asset(
          "assets/images/$bankName.png",
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: screenHeight * 0.1,
              decoration: BoxDecoration(
                color: colorWithOpacity(gris, 0.3),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Center(
                child: Text(
                  bankName.toUpperCase(),
                  style: TextStyle(
                    color: blanco,
                    fontSize: screenWidth < 360 ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
