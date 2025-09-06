import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FormProduccion extends StatefulWidget {
  const FormProduccion({super.key});

  @override
  State<FormProduccion> createState() => _FormProduccionState();
}

class _FormProduccionState extends State<FormProduccion> {
  double _progress = 0;
  late InAppWebViewController _webViewController;

  final String _formUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSeSv6nSoPoHBHAw0vYOHGWHDyyNmG39IItbdUNhba5JctsR9g/viewform';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop && await _webViewController.canGoBack()) {
          _webViewController.goBack();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri.uri(
                    Uri.parse(_formUrl),
                  ),
                ),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onReceivedError: (controller, request, error) {
                  debugPrint(
                      'Error cargando formulario: \\${error.description}');
                  // Mostrar mensaje de error al usuario
                },
              ),
              if (_progress < 1)
                LinearProgressIndicator(
                  value: _progress,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
