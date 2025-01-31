import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerBase extends ConsumerWidget {
  final String videoId;
  final String title;

  const YoutubePlayerBase({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
    );
  }
}
