import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendlyWebview extends StatelessWidget {
  CalendlyWebview({Key? key}) : super(key: key);
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 35,
            color: Colors.black87,
          ),
          onPressed: () => Modular.to.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Agendamento de consulta',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: WebView(
        initialUrl: 'https://calendly.com/juliana-galante/consulta-de-saude-da-mulher',
        zoomEnabled: false,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
            name: 'flutterChannel',
            onMessageReceived: (JavascriptMessage message) {
              // Captura a mensagem emitida pelo JavaScript
              final String data = message.message;
              print('Evento do JavaScript: $data');
            },
          ),
        },
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
      ),
    );
  }
}
