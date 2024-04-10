import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerComponent1 extends StatefulWidget {
  const YoutubePlayerComponent1({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerComponent1> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerComponent1> {
  final videoURL = 'https://www.youtube.com/watch?v=XV5JRrnH9mc';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      // initialVideoId: "-FyRTd0k5Ao",

      flags: YoutubePlayerFlags(
        isLive: true,
        autoPlay: false,
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
          onReady: () {},
        ),
      ],
    );
  }
}
