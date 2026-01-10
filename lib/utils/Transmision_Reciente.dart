import 'package:flutter/material.dart';
import '../widgets/youtube_player_base.dart';

class TransmisionReciente extends StatelessWidget {
  const TransmisionReciente({super.key});

  @override
  Widget build(BuildContext context) {
    return const YoutubePlayerComponent1();
  }
}

class YoutubePlayerComponent1 extends StatelessWidget {
  const YoutubePlayerComponent1({super.key});

  @override
  Widget build(BuildContext context) {
    return const YoutubePlayerBase(
      videoId: 'c5GWRFVO9MM',
      title: 'Transmisión Reciente',
    );
  }
}
