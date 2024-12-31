import 'package:flutter/material.dart';
import '../widgets/youtube_player_base.dart';

class YoutubePlayerComponent1 extends StatelessWidget {
  const YoutubePlayerComponent1({super.key});

  @override
  Widget build(BuildContext context) {
    return const YoutubePlayerBase(
      videoId: 'Zy8JB0yOh2g',
      title: 'Transmisión Reciente',
    );
  }
}
