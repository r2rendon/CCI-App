import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Informacion/actividades_externas.dart';
import '../home/constantes.dart';
import '../services/aws_services.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  final _database = FirebaseDatabase.instance.ref();
  String _serieTitle = '';
  String _serieImage = '';
  String _serieThemes = '';
  String _monthlyEvents = '';
  List<Anuncio> _anuncios = [];
  bool _loadingAnuncio = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    if (_anuncios.isEmpty) {
      _loadingAnuncios();
    }else{
      setState(() {
        _loadingAnuncio = false;
      });
    }
  }

  Future<void> _loadingAnuncios() async {
    try {
      _anuncios = await fetchAnuncios();
      print("Se cargaron los anuncios");
      setState(() {
        _loadingAnuncio = false;
      });
    } catch (e) {
      debugPrint('Error cargando anuncios: $e');
      _showErrorMessage();
    }
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
        content:
            Text('Error al cargar los datos. Por favor, intenta de nuevo.'),
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
                _buildAnuncios(),
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
          Text(
            _serieTitle.toUpperCase(),
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: blanco,
            ),
          ),
          const SizedBox(height: 20),
          Image.network(
            _serieImage,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              "assets/images/Serie.png",
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          const SizedBox(height: 20),
          _buildSeriesContent(),
          const Divider(color: gris),
        ],
      ),
    );
  }

  Widget _buildSeriesContent() {
    final themes = _serieThemes.split(',');
    return Column(
      children: [
        const Center(
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
        ...themes
            .map((theme) => Text(
                  theme.trim(),
                  style: const TextStyle(color: barr),
                ))
            .toList(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEventsSection() {
    final events = _monthlyEvents.split('|');
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
          ...events.asMap().entries.map((entry) {
            final eventData = entry.value.split(',');
            if (eventData.length >= 3) {
              return _buildEventCard(
                eventData[0].trim(),
                eventData[1].trim(),
                eventData[2].trim(),
                entry.key % 2 == 0,
                showMap: eventData.length > 3 && eventData[3].trim() == 'true',
              );
            }
            return const SizedBox.shrink();
          }).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEventCard(
      String title, String date, String location, bool isRight,
      {bool showMap = false}) {
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
              date,
              style: const TextStyle(
                color: blanco,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              location,
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

  Widget _buildAnuncios() {
    if (_loadingAnuncio) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_anuncios.isEmpty) {
      return const Center(
        child: Text(
          'No hay anuncios disponibles',
          style: TextStyle(color: blanco),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: Text(
        "Anuncios",
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: blanco,
        ),
        ),
      ),
      SizedBox(
        height: 200,
        child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _anuncios.length,
        itemBuilder: (context, index) {
          final anuncio = _anuncios[index];
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 5,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
              anuncio.imagenUrl,
              width: 300,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                Image.asset(
                "assets/images/transmision.png",
                width: 300,
                height: 150,
                fit: BoxFit.cover,
              ),
              ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                anuncio.titulo,
                style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                ),
              ),
              ),
            ],
            ),
          ),
          );
        },
        ),
      ),
      ],
    );
  }
}
