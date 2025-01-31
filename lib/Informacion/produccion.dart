import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final progressProvider = StateProvider<double>((ref) => 0);

class FormProduccion extends ConsumerStatefulWidget {
  const FormProduccion({Key? key}) : super(key: key);

  @override
  ConsumerState<FormProduccion> createState() => _FormProduccionState();
}

class _FormProduccionState extends ConsumerState<FormProduccion> {
  late InAppWebViewController _webViewController;
  final _formUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSeSv6nSoPoHBHAw0vYOHGWHDyyNmG39IItbdUNhba5JctsR9g/viewform';

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressProvider);

    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(_formUrl)),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onProgressChanged: (controller, value) {
                  ref.read(progressProvider.notifier).state = value / 100;
                },
                onLoadError: (controller, url, code, message) {
                  debugPrint('Error cargando formulario: $message');
                },
              ),
              if (progress < 1)
                LinearProgressIndicator(value: progress),
            ],
          ),
        ),
      ),
    );
  }
}
