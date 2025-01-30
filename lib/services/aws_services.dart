import 'package:http/http.dart' as http;
import 'dart:convert';

class Anuncio {
  final String imagenUrl;
  final String titulo;
  final DateTime fecha;
  final String descripcion;

  Anuncio({
    required this.imagenUrl,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
  });
}

Future<List<Anuncio>> fetchAnuncios() async {
  final response = await http.get(
    Uri.parse("https://3immuoadfb.execute-api.us-east-2.amazonaws.com/beta/GetAnuncios"),
    headers: {
      'Authorization': 'rIKNgxG5yP^%Jgidh7#Ko%^',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((anuncio) => Anuncio(
      imagenUrl: anuncio['imagenUrl'],
      titulo: anuncio['titulo'],
      fecha: DateTime.parse(anuncio['fecha']),
      descripcion: anuncio['descripcion'],
    )).toList();
  } else {
    throw Exception('Failed to load Anuncios');
  }
}