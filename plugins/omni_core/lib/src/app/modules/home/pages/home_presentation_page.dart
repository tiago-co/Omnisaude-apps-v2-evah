import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_general/src/stores/user_store.dart';

class HomePresentationPage extends StatefulWidget {
  const HomePresentationPage({Key? key}) : super(key: key);

  @override
  _HomePresentationPageState createState() => _HomePresentationPageState();
}

class _HomePresentationPageState extends State<HomePresentationPage> {
  final ModulesStore modulesStore = Modular.get();
  final ProgramStore programStore = Modular.get();
  final UserStore userStore = Modular.get();

  @override
  void initState() {
    userStore.updateUser().then((prefs) async {
      programStore.update(prefs!.beneficiary!.programs!);
      userStore.firebaseService.onSubscribeToTopic(userStore.userId);
      await modulesStore.getActiveModules().then((value) {
        Modular.to.pushNamedAndRemoveUntil(
          '/home',
          ModalRoute.withName('/home'),
        );
      });
    }).catchError((onError) {
      Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.background,
        child: Lottie.asset(
          Assets.lottieLoading,
          package: AssetsPackage.omniCore,
        ),
      ),
    );
  }
}
