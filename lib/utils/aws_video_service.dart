import 'dart:convert';
import 'package:http/http.dart' as http;
import 'aws_config.dart';

class AWSVideoService {
  static Future<Map<String, String>> getVideoIds() async {
    try {
      final response = await http.get(
        Uri.parse('${AWSConfig.liveVideosEndpoint}/ci-live-videos'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'liveVideoId': data['liveVideoId'] ?? '',
          'recentVideoId': data['recentVideoId'] ?? '',
        };
      } else {
        // Si falla, retornar valores por defecto
        return {
          'liveVideoId': '',
          'recentVideoId': 'c5GWRFVO9MM', // Video reciente por defecto
        };
      }
    } catch (e) {
      // En caso de error, usar valores por defecto
      return {
        'liveVideoId': '',
        'recentVideoId': 'c5GWRFVO9MM',
      };
    }
  }
}

