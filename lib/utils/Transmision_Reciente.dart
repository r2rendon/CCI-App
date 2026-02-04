import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/youtube_player_base.dart';
import '../utils/constants.dart';
import 'aws_video_service.dart';

class TransmisionReciente extends StatefulWidget {
  const TransmisionReciente({super.key});

  @override
  State<TransmisionReciente> createState() => _TransmisionRecienteState();
}

class _TransmisionRecienteState extends State<TransmisionReciente> {
  String? _recentVideoId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecentVideo();
  }

  Future<void> _fetchRecentVideo() async {
    try {
      final videoIds = await AWSVideoService.getVideoIds();
      final recentId = videoIds['recentVideoId'] ?? 'c5GWRFVO9MM';
      if (kDebugMode) {
        debugPrint('[TransmisionReciente] recentVideoId recibido: "$recentId"');
      }
      if (mounted) {
        setState(() {
          _recentVideoId = recentId;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _recentVideoId = 'c5GWRFVO9MM'; // Fallback
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _LoadingWidget();
    }

    return YoutubePlayerBase(
      videoId: _recentVideoId ?? 'c5GWRFVO9MM',
      title: 'Transmisión Reciente',
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: colorWithOpacity(negro, 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: colorWithOpacity(accent, 0.08),
                blurRadius: 20,
                offset: const Offset(0, 2),
                spreadRadius: -4,
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: negro,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF007AFF)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
