import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../widgets/swipe_back_wrapper.dart';

class FormProduccion extends StatefulWidget {
  const FormProduccion({super.key});

  @override
  State<FormProduccion> createState() => _FormProduccionState();
}

class _FormProduccionState extends State<FormProduccion> {
  double _progress = 0;
  InAppWebViewController? _webViewController;

  final String _formUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSeSv6nSoPoHBHAw0vYOHGWHDyyNmG39IItbdUNhba5JctsR9g/viewform';

  @override
  Widget build(BuildContext context) {
    return SwipeBackWrapper(
      onBack: () async {
        if (_webViewController != null) {
          if (await _webViewController!.canGoBack()) {
            _webViewController!.goBack();
            return;
          }
        }
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop && _webViewController != null && await _webViewController!.canGoBack()) {
            _webViewController!.goBack();
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
      ),
    );
  }
}
