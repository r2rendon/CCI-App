import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerBase extends StatefulWidget {
  final String videoId;
  final String title;
  
  const YoutubePlayerBase({
    required this.videoId,
    required this.title,
    super.key,
  });

  @override
  State<YoutubePlayerBase> createState() => _YoutubePlayerBaseState();
}

class _YoutubePlayerBaseState extends State<YoutubePlayerBase> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        showLiveFullscreenButton: true,
        controlsVisibleAtStart: true,
        useHybridComposition: true,
      ),
    )..addListener(_onPlayerStateChange);
  }

  void _onPlayerStateChange() {
    if (_controller.value.isReady && !_isPlayerReady) {
      setState(() {
        _isPlayerReady = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          setState(() {
            _isPlayerReady = true;
          });
        },
        onEnded: (metaData) {
          _controller.pause();
        },
        topActions: [
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
            if (!_isPlayerReady)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }
}