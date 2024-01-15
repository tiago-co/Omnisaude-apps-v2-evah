import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatbotWebview extends StatelessWidget {
  ChatbotWebview({Key? key}) : super(key: key);
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
          'Enfermeira Virtual',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: WebView(
        initialUrl: 'https://chat.omnisaude.co/chat?id=ad2051aa-c258-4d2a-b3bf-5c13f2bc4578&color=139ecc',
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
