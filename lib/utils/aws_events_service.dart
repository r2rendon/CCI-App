import 'dart:convert';
import 'package:http/http.dart' as http;
import 'aws_config.dart';
import '../models/event_model.dart';

class AWSEventsService {
  static Future<List<EventModel>> getEvents() async {
    try {
      final response = await http.get(
        Uri.parse('${AWSConfig.eventsEndpoint}/events'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final eventsList = data['events'] as List;
        return eventsList.map((event) => EventModel.fromJson(event)).toList();
      } else {
        // Si falla, retornar lista vacía
        return [];
      }
    } catch (e) {
      // En caso de error, retornar lista vacía
      return [];
    }
  }
}

