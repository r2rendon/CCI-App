import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerComponent1 extends StatefulWidget {
  const YoutubePlayerComponent1({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerComponent1> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerComponent1> {
  YoutubePlayerController? _controller;
  String? videoURL;

  @override
  void initState() {
    super.initState();
    _fetchVideoURL();
  }

  Future<void> _fetchVideoURL() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('trasmissionLive2').get();
    if (snapshot.exists) {
      setState(() {
        final value = snapshot.value;
        if (value is String) {
          videoURL = value;
        } else if (value is Map<Object?, Object?>) {
          // Asumiendo que el mapa tiene una clave "url" que contiene la URL del video
          videoURL = value['url'] as String?;
        } else {
          videoURL = '';
        }

        if (videoURL != null && videoURL!.isNotEmpty) {
          final videoId = YoutubePlayer.convertUrlToId(videoURL!);
          _controller = YoutubePlayerController(
            initialVideoId: videoId!,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              forceHD: true,
              enableCaption: true,
              showLiveFullscreenButton: true,
            ),
          );
        }
      });
    } else {
      setState(() {
        videoURL = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (videoURL != null && videoURL!.isNotEmpty && _controller != null)
          YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
            progressIndicatorColor: const Color.fromARGB(255, 255, 7, 7),
            progressColors: const ProgressBarColors(
              playedColor: Color.fromARGB(255, 255, 7, 7),
              handleColor: Color.fromARGB(255, 255, 7, 7),
            ),
            onReady: () {},
          )
        else
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
