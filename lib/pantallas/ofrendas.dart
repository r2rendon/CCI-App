import 'package:flutter/material.dart';
import '../home/constantes.dart';
import '../widgets/swipe_back_wrapper.dart';

class Ofrendas extends StatelessWidget {
  const Ofrendas({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SwipeBackWrapper(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: getGradientBackground(),
        child: SafeArea(
          child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getHorizontalPadding(screenWidth),
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  _buildHeader(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildLocation(screenWidth),
                SizedBox(height: screenHeight * 0.04),
                _buildDescription(screenWidth),
                _buildBiblicalQuote(screenWidth),
                _buildBankAccounts(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.08),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Text(
      "Dar",
      overflow: TextOverflow.visible,
      style: getTitulo(screenWidth),
    );
  }

  Widget _buildLocation(double screenWidth) {
    return Text(
      "San Pedro Sula",
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        color: grisMedio,
        fontSize: screenWidth < 360 ? 15 : 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.41,
      ),
    );
  }

  Widget _buildDescription(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Text(
        "La generosidad es una expresión de nuestro amor hacia Dios y hacia los demás. "
        "En CCI creemos que dar es un acto de adoración que nos permite ser parte de la "
        "obra de Dios en nuestra comunidad y en el mundo.",
        overflow: TextOverflow.visible,
        style: TextStyle(
          height: 1.5,
          fontSize: screenWidth < 360 ? 16 : 18,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildBiblicalQuote(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: colorWithOpacity(blanco, 0.1),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: colorWithOpacity(blanco, 0.2)),
        ),
        child: Column(
          children: [
            Text(
              '"Cada uno debe dar según lo que haya decidido en su corazón, no de mala gana ni por obligación, porque Dios ama al que da con alegría."',
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: blanco,
                fontSize: screenWidth < 360 ? 14 : 16,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth * 0.03),
            Text(
              '2 Corintios 9:7',
              style: TextStyle(
                color: colorWithOpacity(blanco, 0.8),
                fontSize: screenWidth < 360 ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankAccounts(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Formas de Dar",
            overflow: TextOverflow.visible,
            style: getThema(screenWidth),
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildBankAccountCard(
            "Banco Atlántida",
            "Cuenta Corriente: 123-456-789",
            "A nombre de: Centro Cristiano Internacional",
            screenWidth,
          ),
          SizedBox(height: screenWidth * 0.03),
          _buildBankAccountCard(
            "Banco Ficohsa",
            "Cuenta Ahorros: 987-654-321",
            "A nombre de: Centro Cristiano Internacional",
            screenWidth,
          ),
          SizedBox(height: screenWidth * 0.03),
          _buildBankAccountCard(
            "Transferencia Digital",
            "Zelle / PayPal: info@ccisanpedrosula.com",
            "Para donaciones internacionales",
            screenWidth,
          ),
          SizedBox(height: screenWidth * 0.05),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: colorWithOpacity(azulPrimario, 0.2),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: azulPrimario),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.info_outline,
                  color: azulPrimario,
                  size: screenWidth * 0.06,
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  "Todas las ofrendas y diezmos son utilizados para el mantenimiento "
                  "de la iglesia, misiones, y programas comunitarios.",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: blanco,
                    fontSize: screenWidth < 360 ? 13 : 14,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankAccountCard(
    String bankName,
    String accountNumber,
    String accountHolder,
    double screenWidth,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: colorWithOpacity(blanco, 0.1),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: colorWithOpacity(blanco, 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bankName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: blanco,
              fontSize: screenWidth < 360 ? 15 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            accountNumber,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: colorWithOpacity(blanco, 0.9),
              fontSize: screenWidth < 360 ? 13 : 14,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            accountHolder,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: colorWithOpacity(blanco, 0.7),
              fontSize: screenWidth < 360 ? 12 : 13,
            ),
          ),
        ],
      ),
    );
  }
}
