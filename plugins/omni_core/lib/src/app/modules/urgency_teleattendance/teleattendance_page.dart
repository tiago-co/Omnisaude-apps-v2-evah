import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeleattendancePage extends StatefulWidget {
  final String? moduleName;
  const TeleattendancePage({Key? key, required this.moduleName})
      : super(key: key);

  @override
  State<TeleattendancePage> createState() => _TeleattendancePageState();
}

class _TeleattendancePageState extends State<TeleattendancePage> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName!).build(context) as AppBar,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Você está saindo do app',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 22,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'Você será redirecionado para o atendimento via whatsapp',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            DefaultButtonWidget(
              onPressed: () async {
                await launchUrl(
                  Uri.parse('https://wa.me/message/U3FWBVIFTGLKP1'),
                  mode: LaunchMode.externalApplication,
                ).then((value) {
                  Modular.to.pop();
                });
              },
              text: 'Entendo e concordo',
            ),
            const SizedBox(height: 10),
            DefaultButtonWidget(
              onPressed: () => Modular.to.pop(),
              text: 'Voltar',
              buttonType: DefaultButtonType.outline,
            ),
          ],
        ),
      ),
      // body: WebView(
      //   initialUrl:
      //       'https://eusaude.com.vc/b2b_evah/?alx777-get-user-dna=%F0%9F%91%A4%E2%80%89Juarez%E2%A0%80%E2%98%8E%EF%B8%8F%E2%80%8931988623421%E2%A0%80%20%E2%80%8983469014027%E2%A0%80%F0%9F%93%A7%E2%80%89juarez.henrique@eusaude.com.br%E2%A0%80%F0%9F%8F%A5%E2%80%89EUSAUDE%E2%A0%80%F0%9F%94%B0%E2%80%89TRIMESTRAL',
      //   zoomEnabled: false,
      //   javascriptMode: JavascriptMode.unrestricted,
      //   javascriptChannels: {
      //     JavascriptChannel(
      //       name: 'flutterChannel',
      //       onMessageReceived: (JavascriptMessage message) {
      //         // Captura a mensagem emitida pelo JavaScript
      //         final String data = message.message;
      //         print('Evento do JavaScript: $data');
      //       },
      //     ),
      //   },
      //   onWebViewCreated: (controller) {
      //     _webViewController = controller;
      //   },
      // ),
      // body: const WebviewScaffold(
      //   url: 'https://eusaude.com.vc/b2b_evah/?alx777-get-user-dna',
      //   hidden: true, // Opcional: oculta a webview até que ela esteja carregada
      // ),
    );
  }
}
