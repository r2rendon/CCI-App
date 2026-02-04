import 'dart:convert';
import 'package:http/http.dart' as http;
import 'aws_config.dart';
import '../models/event_model.dart';

/// Servicio de eventos en AWS. Eventos general = pantalla Eventos principal.
/// Eventos por ministerio = Next, Alive, Shift (categorías: next, alive, shift).
class AWSEventsService {
  /// Eventos general: pantalla "Eventos" principal (sin filtro de categoría).
  static Future<List<EventModel>> getEventsGeneral() async {
    return getEventsForMinistry(null);
  }

  /// Eventos de un ministerio (next, alive, shift). null = todos (Eventos general).
  static Future<List<EventModel>> getEventsForMinistry(String? category) async {
    try {
      final uri = category != null && category.isNotEmpty
          ? Uri.parse('${AWSConfig.eventsEndpoint}/events').replace(
              queryParameters: {'category': category},
            )
          : Uri.parse('${AWSConfig.eventsEndpoint}/events');
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final eventsList = data['events'] as List? ?? [];
        return eventsList.map((event) => EventModel.fromJson(event as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

