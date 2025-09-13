import 'package:flutter/material.dart';
import '../widgets/youtube_player_base.dart';

class TransmisionLive extends StatelessWidget {
  const TransmisionLive({super.key});

  @override
  Widget build(BuildContext context) {
    return const YoutubePlayerComponent();
  }
}

class YoutubePlayerComponent extends StatelessWidget {
  const YoutubePlayerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const YoutubePlayerBase(
      videoId: 'Zy8JB0yOh2g',
      title: 'Transmisión en Vivo',
    );
  }
}
