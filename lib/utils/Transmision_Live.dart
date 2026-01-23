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

    // Si no hay videoId, mostramos un placeholder (imagen o mensaje)
    if (_liveVideoId == null || _liveVideoId!.isEmpty) {
      return _LiveFallback(
        title: widget.title,
        imagePath: widget.fallbackImagePath ?? 'assets/images/live_placeholder.png',
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
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        color: blanco,
                        fontSize: screenWidth < 360 ? 20 : 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: grisCard,
                          borderRadius: BorderRadius.circular(borderRadius),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        color: blanco,
                        fontSize: screenWidth < 360 ? 20 : 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: grisCard,
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(
                            color: colorWithOpacity(blanco, 0.1),
                            width: 0.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: grisCard,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.live_tv_outlined,
                                        color: grisMedio,
                                        size: screenWidth * 0.12,
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
