import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/youtube_player_base.dart';

class YoutubePlayerComponent extends ConsumerWidget {
  const YoutubePlayerComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const YoutubePlayerBase(
      videoId: 'Zy8JB0yOh2g',
      title: 'Transmisión en Vivo',
    );
  }
}
