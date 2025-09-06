import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../home/constantes.dart';

class YoutubePlayerBase extends StatelessWidget {
  final String videoId;
  final String title;

  const YoutubePlayerBase({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: false,
        showControls: true,
        enableCaption: false,
        showVideoAnnotations: false,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01,
            horizontal: screenWidth * 0.02,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth < 360 ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: blanco,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: defaultShadow,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayer(
                controller: controller,
                aspectRatio: 16 / 9,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
