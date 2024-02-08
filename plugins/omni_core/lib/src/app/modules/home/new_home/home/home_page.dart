import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/bottom_navigation_store.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/home_content.dart';

import 'package:omni_core/src/app/modules/home/pages/stores/home_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/omniplan_module_icon_store.dart';
import 'package:omni_core/src/app/modules/new_profile/profile_page.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/omni_mediktor.dart';

import 'widgets/bottom_navigation_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();
  final UserStore userStore = Modular.get();
  final ProgramStore programStore = Modular.get();
  final OmniplanModuleIconStore omniplanModuleIconStore = Modular.get();
  final MediktorDiagnosisStore mediktorDiagnosisStore = Modular.get();
  final BottomNavigationStore _navigationStore = Modular.get();
  final List<Widget> pages = [
    HomePageContent(),
    // ReminderPage(),
    // SizedBox(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
    userStore.updateUser().then((prefs) async {
      // programStore.update(prefs!.beneficiary!.programs!);
      userStore.firebaseService.onSubscribeToTopic(userStore.userId.toString());
    });
    // store.modulesStore.getActiveModules().then(
    //   (value) {
    //     omniplanModuleIconStore.getOmniPlanModuleStatus();
    //     store.modulesStore.state.any((element) => element.type == ModuleType.mediktor)
    //         ? mediktorDiagnosisStore.authenticate()
    //         : null;
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: TripleBuilder<BottomNavigationStore, Exception, int>(
        store: _navigationStore,
        builder: (_, triple) {
          return pages[triple.state];
        },
      ),
    );
  }
}
