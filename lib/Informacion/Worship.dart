import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final worshipProgressProvider = StateProvider<double>((ref) => 0.0);
final worshipWebViewControllerProvider =
  StateProvider<InAppWebViewController?>((ref) => null);

class FormWorship extends ConsumerWidget {
  const FormWorship({super.key});

  final String _formUrl =
    'https://docs.google.com/forms/d/e/1FAIpQLSeSv6nSoPoHBHAw0vYOHGWHDyyNmG39IItbdUNhba5JctsR9g/viewform';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final progress = ref.watch(worshipProgressProvider);
  final controller = ref.watch(worshipWebViewControllerProvider);

  return WillPopScope(
    onWillPop: () async {
    if (await controller?.canGoBack() ?? false) {
      controller?.goBack();
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
        onWebViewCreated: (c) {
          ref.read(worshipWebViewControllerProvider.notifier).state = c;
        },
        onProgressChanged: (_, p) {
          ref.read(worshipProgressProvider.notifier).state = p / 100.0;
        },
        onLoadError: (_, __, ___, ____) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
            'Error al cargar el formulario. Por favor, intenta de nuevo.',
            ),
            duration: Duration(seconds: 3),
          ),
          );
        },
        ),
        if (progress < 1) LinearProgressIndicator(value: progress),
      ],
      ),
    ),
    ),
  );
  }
}
