import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Informacion/actividades_externas.dart';
import '../home/constantes.dart';
import '../services/notifierProvider.dart';

class Eventos extends ConsumerStatefulWidget {
  const Eventos({Key? key}) : super(key: key);

  @override
  ConsumerState<Eventos> createState() => _EventosState();
}

class _EventosState extends ConsumerState<Eventos> {
  // final _database = FirebaseDatabase.instance.ref();
  String _serieTitle = '';
  String _serieImage = '';
  String _serieThemes = '';
  String _monthlyEvents = '';

  @override
  void initState() {
    super.initState();
  }


  Future<void> _loadData() async {
    try {
      // Here you would call your AWS service methods
      // Example:
      // final data = await awsService.getEventData();
      if (mounted) {
        setState(() {
          // Update state with AWS data when implemented
          _serieTitle = 'Test Title';
          _serieImage = 'Test Image';
          _serieThemes = 'Test Themes';
          _monthlyEvents = 'Test Events';
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
    final noticias = ref.watch(proveedorNoticias);
    print("tamaño de noticias");
    print(noticias.length);
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
                _buildAnuncios(noticias),
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

  Widget _buildAnuncios(List<dynamic> _anuncios) {  
    
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
