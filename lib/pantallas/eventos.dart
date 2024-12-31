import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Informacion/actividades_externas.dart';
import '../home/constantes.dart';

class Eventos extends StatefulWidget { // Cambiar a StatefulWidget para manejar estados
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  // Controladores para los datos de Firebase
  final _database = FirebaseDatabase.instance.ref();
  String _serieTitle = '';
  String _serieImage = '';
  String _serieThemes = '';
  String _monthlyEvents = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final serieTitle = await _database.child('serieTitle').get();
      final serieImage = await _database.child('serieImage').get();
      final serieThemes = await _database.child('serieThemes').get();
      final monthlyEvents = await _database.child('monthlyEvents').get();

      if (mounted) {
        setState(() {
          _serieTitle = serieTitle.value?.toString() ?? '';
          _serieImage = serieImage.value?.toString() ?? '';
          _serieThemes = serieThemes.value?.toString() ?? '';
          _monthlyEvents = monthlyEvents.value?.toString() ?? '';
        });
      }
    } catch (e) {
      debugPrint('Error cargando datos: $e');
      _showErrorMessage();
    }
  }

  void _showErrorMessage() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error al cargar los datos. Por favor, intenta de nuevo.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                _buildWelcomeMessage(),
                _buildSeriesSection(),
                _buildEventsSection(),
              ],
            ),
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
            "Eventos del mes",
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

  Widget _buildWelcomeMessage() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hola! Tú eres parte de la gran familia de CCI San Pedro Sula, y por esto queremos que estés enterado de todo lo que se viene! "
            "Aquí encontrarás los próximos eventos para que puedas agendar las fechas y no te pierdas de nada.",
            style: TextStyle(
              height: 1.5,
              fontSize: 18,
              color: blanco,
            ),
          ),
          SizedBox(height: 20),
          Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildSeriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LA VERDADERA GRANDEZA',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: blanco,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            "assets/images/Serie.png",
            opacity: const AlwaysStoppedAnimation(.3),
          ),
          const SizedBox(height: 20),
          _buildSeriesContent(),
          const Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildSeriesContent() {
    return Column(
      children: const [
        Center(
          child: Text(
            "Serie del Mes",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: blanco,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Text(
          "No hay mejor manera de servir",
          style: TextStyle(
            color: blanco,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text("1. Como el que sirve.", style: TextStyle(color: barr)),
        Text("2. Acciones Sinceras.", style: TextStyle(color: barr)),
        Text("3. Unidos.", style: TextStyle(color: barr)),
        Text("4. Confiables.", style: TextStyle(color: barr)),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEventsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "EVENTOS DE ABRIL",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: blanco,
            ),
          ),
          _buildEventCard(
            "Conferencia Especializada",
            "Viernes 26 de Abril",
            "Templo CCI SPS",
            true,
          ),
          _buildEventCard(
            "Shift Night",
            "Viernes 12 de Abril",
            "Kilo Bistro",
            false,
            showMap: true,
          ),
          _buildEventCard(
            "Otro Evento/Actividad",
            "Sabado 13 de Abril",
            "ejemplo de Widget plus",
            true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String date, String location, bool isRight, {bool showMap = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: isRight ? 100 : 0,
        right: isRight ? 0 : 100,
      ),
      child: Card(
        elevation: 1,
        color: const Color.fromARGB(10, 255, 255, 255),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: blanco,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " - $date",
              style: const TextStyle(
                color: blanco,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "  - $location",
              style: const TextStyle(
                color: blanco,
                fontWeight: FontWeight.w300,
              ),
            ),
            if (showMap) const Externa('mapa'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}