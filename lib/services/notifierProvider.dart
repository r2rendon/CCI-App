import 'package:cci_app/services/aws_services.dart' as aws;
import 'package:cci_app/utils/Anuncio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final proveedorNoticias =
    StateNotifierProvider<NewsNotifier, List<aws.Anuncio>>((ref) {
  return NewsNotifier();
});

// Provider para manejar las noticias
class NewsNotifier extends StateNotifier<List<aws.Anuncio>> {
  NewsNotifier() : super([]) {
    loadNews();
  }

  Future<void> loadNews() async {
    final box = await Hive.openBox<Anuncio>('noticiasBox');

    try {
      if (box.isNotEmpty) {
        // Convert Hive Anuncio to AWS Anuncio
        state = box.values
            .map((anuncio) => aws.Anuncio(
                  imagenUrl: anuncio.imagenUrl,
                  titulo: anuncio.titulo,
                  fecha: anuncio.fecha,
                  descripcion: anuncio.descripcion,
                ))
            .toList();

        print("Noticias cargadas desde cache: ${state.length}");
      } else {
        final response = await aws.fetchAnuncios();
        await box.clear();

        // Convert AWS Anuncio to Hive Anuncio
        final hiveAnuncios = response
            .map((awsAnuncio) => Anuncio(
                  imagenUrl: awsAnuncio.imagenUrl,
                  titulo: awsAnuncio.titulo,
                  fecha: awsAnuncio.fecha,
                  descripcion: awsAnuncio.descripcion,
                ))
            .toList();

        await box.addAll(hiveAnuncios);
        state = response;
        print("Noticias cargadas desde API: ${state.length}");
      }
    } catch (e) {
      debugPrint('Error cargando anuncios: $e');
    }
  }
}
