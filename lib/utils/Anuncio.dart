import 'package:hive/hive.dart';

part 'Anuncio.g.dart';

@HiveType(typeId: 1, adapterName: 'AnuncioAdapter')
class Anuncio extends HiveObject {
  @HiveField(0)
  final String imagenUrl;

  @HiveField(1)
  final String titulo;

  @HiveField(2)
  final DateTime fecha;

  @HiveField(3)
  final String descripcion;

  Anuncio({
    required this.imagenUrl,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
  });
}