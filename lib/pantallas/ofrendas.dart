import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';
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
                  _buildBankAccounts(context, screenWidth, screenHeight),
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
      kLocationName,
      overflow: TextOverflow.visible,
      style: getLocationTextStyle(screenWidth),
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
        style: getBodyLargeTextStyle(screenWidth, color: blanco).copyWith(
          height: lineHeightVeryRelaxed,
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
              style: getBiblicalQuoteStyle(screenWidth),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth * 0.03),
            Text(
              '2 Corintios 9:7',
              style: getBiblicalReferenceStyle(screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankAccounts(BuildContext context, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontalPadding(screenWidth) * 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Formas de Dar:\n",
            overflow: TextOverflow.visible,
            style: getThema(screenWidth),
          ),
          Text(
            'Transferencias Bancarias:',
            style: getLabelTextStyle(screenWidth),
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildBankAccountCard(
            context,
            "BAC Credomatic",
            "Cuenta en Lempiras/Cheques: 909536002",
            "Centro Cristiano Internacional",
            "909536002",
            screenWidth,
          ),
          SizedBox(height: screenWidth * 0.03),
          _buildBankAccountCard(
            context,
            "Atlántida",
            "Cuenta en Lempiras/Cheques: 2100151261",
            "Centro Cristiano Internacional",
            "2100151261",
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
                  style: getInfoTextStyle(screenWidth),
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
    BuildContext context,
    String bankName,
    String accountNumber,
    String accountHolder,
    String numberToCopy,
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
            style: getCardContentStyle(screenWidth, color: blanco).copyWith(
              fontSize: getFontSizeBodyXLarge(screenWidth),
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  accountNumber,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: getMonospaceTextStyle(screenWidth),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: numberToCopy));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Número copiado: $numberToCopy'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Icon(
                      Icons.copy_rounded,
                      size: screenWidth * 0.06,
                      color: accent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            accountHolder,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: getBodySmallTextStyle(screenWidth,
                color: colorWithOpacity(blanco, 0.7)),
          ),
        ],
      ),
    );
  }
}
