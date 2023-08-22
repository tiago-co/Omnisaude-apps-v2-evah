import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';

import 'package:omni_core/src/app/modules/splash/splash_store.dart';
import 'package:omni_core/src/app/shared/widgets/new_version_dialog/new_version_dialog.dart';
import 'package:omni_general/omni_general.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashStore store = Modular.get();

  @override
  void initState() {
    getPermissions();
    store.verifyAppVersion().then((isUpdated) async {
      if (!isUpdated) {
        await Helpers.showDialog(
          context,
          const NewVersionDialog(),
        );
      }
      store.getBeneficiaryData().then((value) async {
        Modular.to.pushReplacementNamed('/home');
      }).catchError((onError) {
        Modular.to.pushReplacementNamed('/presentation');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Theme.of(context).splashColor.withOpacity(0.5),
              Theme.of(context).splashColor,
              Theme.of(context).splashColor.withOpacity(0.95),
            ],
          ),
        ),
        child: SvgPicture.asset(
          Assets.logoSplash,
          height: 130,
        ),
      ),
    );
  }
}
