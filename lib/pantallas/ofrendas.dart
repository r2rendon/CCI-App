import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/constantes.dart';

class Ofrendas extends ConsumerWidget {
  const Ofrendas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: negro,
      body: SingleChildScrollView(
        child: Container(
          decoration: decorations,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildLocation(),
              const SizedBox(height: 20),
              _buildDescription(),
              _buildBiblicalQuote(),
              _buildBankAccounts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Dar",
            style: titulo,
          ),
          Image.asset(
            "assets/images/logo.png",
            height: 45,
            color: blanco,
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        "San Pedro Sula",
        style: TextStyle(color: blanco),
      ),
    );
  }

  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: Text(
        "Hemos dispuesto nuestras cuentas bancarias para que puedas dar tus diezmos y ofrendas",
        style: TextStyle(
          fontSize: 18,
          height: 1.5,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildBiblicalQuote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 20),
          Divider(color: gris),
          Text(
            "Proverbios 3:9-10",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blanco,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Honra al Señor con tus riquezas y con lo mejor de todo lo que produces. '
            'Entonces él llenará tus graneros, y tus tinajas se desbordarán de buen vino.',
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: blanco,
            ),
          ),
          SizedBox(height: 20),
          Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildBankAccounts() {
    return Column(
      children: [
        _buildBankCard("bac"),
        const SizedBox(height: 20),
        _buildBankCard("atlantida"),
        const SizedBox(height: 20),
        const Divider(color: gris),
      ],
    );
  }

  Widget _buildBankCard(String bankName) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(10, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        "assets/images/$bankName.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
