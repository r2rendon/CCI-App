import 'package:flutter/material.dart';
import '../home/constantes.dart';

class Ofrendas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //logo cci
                  Image.asset(
                    "assets/images/logo.png",
                    height: 45,
                    color: Colors.grey[800],
                  ),

                  //ofrendas icon
                  Icon(
                    Icons.mobile_friendly,
                    color: Colors.grey[800],
                    size: 43,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //Centro Cristiano Internacional
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("San Pedro Sula"),
                  Text(
                    "Ofrendas",
                    style: TextStyle(
                      fontSize: 40,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
