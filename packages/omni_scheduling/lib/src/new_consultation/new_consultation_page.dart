import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewConsultationPage extends StatelessWidget {
  const NewConsultationPage({Key? key}) : super(key: key);
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
          'Consulta saúde da mulher',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xffED8282),
          // borderRadius: BorderRadius.circular(60),
        ),
        child: TextButton(
          onPressed: () => Modular.to.pushNamed('calendly_webview'),
          child: const Text(
            'Agendar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.7142857143,
              color: const Color(0xffffffff),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.clipboardIcon,
              package: AssetsPackage.omniCore,
              color: Colors.pink,
            ),
            const Text(
              'Agende sua consulta com nossa profissional em saúde da mulher',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
