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
      if (mounted) {
        setState(() {
          _recentVideoId = videoIds['recentVideoId'];
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.3,
      decoration: BoxDecoration(
        color: grisCard,
        border: Border.all(
          color: colorWithOpacity(blanco, 0.1),
          width: 0.5,
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: accent,
        ),
      ),
    );
  }
}
