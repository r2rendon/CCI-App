import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'aws_config.dart';

class AWSVideoService {
  static String _normalizeYoutubeVideoId(String input) {
    final raw = input.trim();
    if (raw.isEmpty) return '';

    // If already an ID (typically 11 chars), return as-is.
    final idPattern = RegExp(r'^[a-zA-Z0-9_-]{11}$');
    if (idPattern.hasMatch(raw)) return raw;

    // Try parse common YouTube URL formats:
    // - https://www.youtube.com/watch?v=VIDEOID
    // - https://youtu.be/VIDEOID
    // - https://www.youtube.com/live/VIDEOID
    // - https://www.youtube.com/embed/VIDEOID
    try {
      final uri = Uri.parse(raw);

      final v = uri.queryParameters['v'];
      if (v != null && idPattern.hasMatch(v)) return v;

      // youtu.be/<id>
      if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
        final seg = uri.pathSegments.first;
        if (idPattern.hasMatch(seg)) return seg;
      }

      // /embed/<id> or /live/<id> or /shorts/<id>
      if (uri.pathSegments.length >= 2) {
        final seg = uri.pathSegments[1];
        if (idPattern.hasMatch(seg)) return seg;
      }
    } catch (_) {
      // ignore
    }

    // Fallback: pick first 11-char token-looking string
    final token = RegExp(r'[a-zA-Z0-9_-]{11}').firstMatch(raw)?.group(0);
    return token ?? '';
  }

  static Future<Map<String, String>> getVideoIds() async {
    final url = '${AWSConfig.liveVideosEndpoint}/ci-live-videos';
    try {
      debugPrint('[AWSVideoService] GET $url');
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint('[AWSVideoService] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final live = _normalizeYoutubeVideoId(data['liveVideoId']?.toString() ?? '');
        debugPrint('[AWSVideoService] parsed liveVideoId="$live"');
        return {
          'liveVideoId': live,
        };
      } else {
        debugPrint('[AWSVideoService] fallback por status != 200');
        return {'liveVideoId': ''};
      }
    } catch (e, st) {
      debugPrint('[AWSVideoService] error: $e');
      debugPrint('[AWSVideoService] stack: $st');
      return {'liveVideoId': ''};
    }
  }
}

