import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OtherDiscountsWebview extends StatefulWidget {
  const OtherDiscountsWebview({Key? key}) : super(key: key);
  @override
  State<OtherDiscountsWebview> createState() => _OtherDiscountsWebviewState();
}

class _OtherDiscountsWebviewState extends State<OtherDiscountsWebview> {
  final UserStore userStore = Modular.get();

  late final WebViewController _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController();
    _webViewController.loadRequest(
      Uri.parse(
        userStore.beneficiary.lecuponUser?.webSmartLink ?? '',
      ),
    );
    _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(title: '').build(context) as AppBar,
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
