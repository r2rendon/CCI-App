import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/constantes.dart';
import '../utils/Transmision_Live.dart';
import '../utils/Transmision_Reciente.dart';

class Transmisiones extends ConsumerWidget {
  const Transmisiones({super.key});

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
              _buildLiveStream(),
              _buildWelcomeMessage(),
              _buildRecentStream(),
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
            "En vivo",
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

  Widget _buildLiveStream() {
    return Column(
      children: const [
        Divider(color: gris),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: YoutubePlayerComponent(),
        ),
        SizedBox(height: 20),
        Divider(color: gris),
      ],
    );
  }

  Widget _buildWelcomeMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Hola Familia! Aquí puedes conectarte a nuestras transmisiones en vivo de "
            "todas las celebraciones para que no te pierdas esa palabra que Dios tiene para ti. "
            "Disfrutemos juntos de este tiempo!",
            style: TextStyle(
              height: 1.5,
              fontSize: 18,
              color: blanco,
            ),
          ),
          SizedBox(height: 20),
          Divider(color: gris),
          SizedBox(height: 20),
          Text(
            "Aquí puedes ver nuestro mensaje más reciente!",
            style: TextStyle(
              height: 1.5,
              fontSize: 18,
              color: blanco,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildRecentStream() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: YoutubePlayerComponent1(),
        ),
        SizedBox(height: 20),
        Divider(color: gris),
      ],
    );
  }
}
