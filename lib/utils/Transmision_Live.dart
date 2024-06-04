import 'package:cci_app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class YoutubePlayerComponent extends StatefulWidget {
  const YoutubePlayerComponent({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerComponent> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerComponent> {
  YoutubePlayerController? _controller;
  String? videoURL;

  @override
  void initState() {
    super.initState();
    _fetchVideoURL();
    _listenForChanges();
  }

  Future<void> _fetchVideoURL() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('trasmissionLive').get();
    if (snapshot.exists) {
      setState(() {
        final value = snapshot.value;
        if (value is String) {
          videoURL = value;
        } else if (value is Map<Object?, Object?>) {
          videoURL = value['url'] as String?;
        } else {
          videoURL = '';
        }

        if (videoURL != null && videoURL!.isNotEmpty) {
          final videoId = YoutubePlayer.convertUrlToId(videoURL!);
          _controller = YoutubePlayerController(
            initialVideoId: videoId!,
            flags: const YoutubePlayerFlags(
              isLive: true,
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

  void _listenForChanges() {
    final ref = FirebaseDatabase.instance.ref().child('trasmissionLive');
    ref.onValue.listen((event) {
      final newValue = event.snapshot.value;
      if (newValue is String) {
        videoURL = newValue;
      } else if (newValue is Map<Object?, Object?>) {
        videoURL = newValue['url'] as String?;
      } else {
        videoURL = '';
      }

      if (videoURL != null && videoURL!.isNotEmpty) {
        final videoId = YoutubePlayer.convertUrlToId(videoURL!);
        setState(() {
          _controller?.load(videoId!);
        });
        _showNotification();
      }
    });
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      // 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Nueva Transmisión en Vivo',
      'Haz clic para ver la transmisión en vivo.',
      platformChannelSpecifics,
    );
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
