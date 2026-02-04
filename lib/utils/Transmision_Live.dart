import 'package:flutter/material.dart';
import '../widgets/youtube_player_base.dart';
import '../utils/constants.dart';
import 'aws_video_service.dart';

class TransmisionLive extends StatefulWidget {
  final String? fallbackImagePath;
  final String title;

  const TransmisionLive({
    super.key,
    this.fallbackImagePath,
    this.title = 'Transmisión en Vivo',
  });

  @override
  State<TransmisionLive> createState() => _TransmisionLiveState();
}

class _TransmisionLiveState extends State<TransmisionLive> {
  String? _liveVideoId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLiveVideo();
  }

  Future<void> _fetchLiveVideo() async {
    try {
      final videoIds = await AWSVideoService.getVideoIds();
      if (mounted) {
        setState(() {
          _liveVideoId = videoIds['liveVideoId'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _liveVideoId = '';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _LoadingWidget(title: widget.title);
    }

    // Cuando no hay transmisión (API devuelve liveVideoId vacío), mostramos
    // siempre la imagen live_placeholder.png.
    if (_liveVideoId == null || _liveVideoId!.isEmpty) {
      return _LiveFallback(
        title: widget.title,
        imagePath: widget.fallbackImagePath ?? kLivePlaceholderAsset,
      );
    }

    return YoutubePlayerBase(
      videoId: _liveVideoId!,
      title: widget.title,
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final String title;

  const _LoadingWidget({required this.title});

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

class _LiveFallback extends StatelessWidget {
  final String title;
  final String imagePath;

  const _LiveFallback({
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: negro,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.live_tv_outlined,
                            color: grisMedio,
                            size: screenWidth * 0.12,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No hay transmisión en vivo',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              color: grisMedio,
                              fontSize: screenWidth < 360 ? 14 : 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
