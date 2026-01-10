import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../home/constantes.dart';

class YoutubePlayerBase extends StatefulWidget {
  final String videoId;
  final String title;

  const YoutubePlayerBase({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  State<YoutubePlayerBase> createState() => _YoutubePlayerBaseState();
}

class _YoutubePlayerBaseState extends State<YoutubePlayerBase> {
  bool _isLoading = true;

  // HTML personalizado con iframe de YouTube optimizado
  String get _htmlContent => '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      margin: 0;
      padding: 0;
      background-color: #000000;
      overflow: hidden;
      width: 100%;
      height: 100%;
    }
    .video-container {
      position: relative;
      width: 100%;
      height: 100vh;
      padding-bottom: 56.25%; /* 16:9 aspect ratio */
    }
    iframe {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      border: none;
    }
  </style>
</head>
<body>
  <div class="video-container">
    <iframe
      src="https://www.youtube.com/embed/${widget.videoId}?autoplay=0&controls=1&rel=0&modestbranding=1&playsinline=1&enablejsapi=1&origin=https://www.youtube.com&iv_load_policy=3"
      frameborder="0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
      allowfullscreen
    ></iframe>
  </div>
</body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: InAppWebView(
            initialData: InAppWebViewInitialData(data: _htmlContent),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              iframeAllow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
              iframeAllowFullscreen: true,
              useHybridComposition: true,
              transparentBackground: true,
              supportZoom: false,
              disableHorizontalScroll: true,
              disableVerticalScroll: true,
            ),
            onWebViewCreated: (controller) {
              // Controller disponible para futuras operaciones si es necesario
            },
            onLoadStart: (controller, url) {
              if (mounted) {
                setState(() {
                  _isLoading = true;
                });
              }
            },
            onLoadStop: (controller, url) async {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            onConsoleMessage: (controller, consoleMessage) {
              debugPrint('WebView console: ${consoleMessage.message}');
            },
          ),
        ),
        if (_isLoading)
          Container(
            color: grisCard,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF007AFF)),
              ),
            ),
          ),
      ],
    );
  }
}
