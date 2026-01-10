import 'package:flutter/material.dart';
import '../home/constantes.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;

  const BackButtonWidget({
    super.key,
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chevron_left_rounded,
                color: primario,
                size: 28,
              ),
              if (text != null) ...[
                SizedBox(width: screenWidth * 0.01),
                Text(
                  text!,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: primario,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.41,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

