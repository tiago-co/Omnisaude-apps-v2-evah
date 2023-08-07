import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/privacy/privacy_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:privacy_labels/labels.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);
  @override
  PrivacyPageState createState() => PrivacyPageState();
}

class PrivacyPageState extends State<PrivacyPage> {
  final PrivacyStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: PrivacyLabels.privacyTitle,
      ).build(context) as AppBar,
      body: Center(
        child: RequestErrorWidget(
          message: PrivacyLabels.privacyError,
          onPressed: () => Modular.to.pop(),
          buttonText: PrivacyLabels.privacyBack,
        ),
      ),
    );
  }
}
