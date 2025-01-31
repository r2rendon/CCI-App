import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Informacion/produccion.dart';
import '../Informacion/Worship.dart';
import '../home/constantes.dart';
import '../redes sociales/ig_alive.dart';

class Ministerios extends ConsumerWidget {
  const Ministerios({super.key});

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
              _buildDescription(),
              _buildMinisteriosList(),
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
            "Ministerios CCI",
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
        "La comunidad de CCI en San Pedro Sula está compuesta por muchos Ministerios "
        "con el fin de poder responder a las necesidades que cada etapa de la vida "
        "nos presenta. Te invitamos a conocerlos para que puedas ser parte también!",
        style: TextStyle(
          height: 1.5,
          fontSize: 18,
          color: blanco,
        ),
      ),
    );
  }

  Widget _buildMinisteriosList() {
    return Column(
      children: [
        _buildMinisterioItem(
          "alabanza",
          "Ser un ministerio entendido de nuestra función como siervos que disciernen "
          "la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio "
          "guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es "
          "Él y lo que ha hecho por nosotros.",
          onTap: () => const FormWorship(),
          buttonText: "Forma parte de nuestro equipo!",
        ),
        _buildMinisterioItem(
          "produccion",
          "Ser un ministerio entendido de nuestra función como siervos que disciernen "
          "la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio "
          "guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es "
          "Él y lo que ha hecho por nosotros.",
          onTap: () => const FormProduccion(),
          buttonText: "Forma parte de nuestro equipo!",
        ),
        _buildMinisterioSocialItem(
          "alive",
          "Ser un ministerio entendido de nuestra función como siervos que disciernen "
          "la voluntad de Dios, el mover del Espíritu Santo y que ejercen su sacerdocio "
          "guiando al pueblo a una alabanza y adoración genuina, recordándoles Quién es "
          "Él y lo que ha hecho por nosotros.",
          const IgAlive('Instagram'),
        ),
        // Repetir para otros ministerios...
      ],
    );
  }

  Widget _buildMinisterioItem(String image, String description, {
    required VoidCallback onTap,
    required String buttonText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: [
          Image.asset("assets/images/$image.png"),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              color: blanco,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: blanco,
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: negro,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinisterioSocialItem(String image, String description, Widget socialButton) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: [
          Image.asset("assets/images/$image.png"),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              color: blanco,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [socialButton],
          ),
        ],
      ),
    );
  }
}
