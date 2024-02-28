import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerComponent extends StatefulWidget {
  const YoutubePlayerComponent({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerComponent> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerComponent> {
  final videoURL = 'http://www.youtube.com/watch?v=-FyRTd0k5Ao';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      // initialVideoId: videoId!,
      initialVideoId: "-FyRTd0k5Ao",

      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
        enableCaption: true,
        showLiveFullscreenButton: true,
      ),
    );
    print(videoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: const Color.fromARGB(255, 255, 7, 7),
          progressColors: const ProgressBarColors(
            playedColor: Color.fromARGB(255, 255, 7, 7),
            handleColor: Color.fromARGB(255, 255, 7, 7),
          ),
          // onReady: () {},
        ),
      ],
    );
  }
}
