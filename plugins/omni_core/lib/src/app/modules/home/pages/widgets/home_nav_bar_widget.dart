import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_general/omni_general.dart';

class HomeNavBarWidget extends StatefulWidget {
  const HomeNavBarWidget({Key? key}) : super(key: key);

  @override
  _HomeNavBarWidgetState createState() => _HomeNavBarWidgetState();
}

class _HomeNavBarWidgetState extends State<HomeNavBarWidget> {
  final UserStore userStore = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // surfaceTintColor: Theme.of(context).colorScheme.background,
      // backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      title: TripleBuilder<UserStore, Exception, PreferencesModel>(
        store: userStore,
        builder: (_, triple) {
          return AbsorbPointer(
            child: ImageWidget(
              url:
                  triple.state.beneficiary!.programSelected!.enterprise!.logo ??
                      '',
              asset: Assets.logoNavBar,
              height: 50,
              width: double.infinity,
            ),
          );
        },
      ),
      automaticallyImplyLeading: false,
    );
  }
}
