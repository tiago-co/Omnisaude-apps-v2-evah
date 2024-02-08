import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/home_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/omniplan_module_icon_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/unread_notifications_count_store.dart';
import 'package:omni_core/src/app/modules/home/pages/widgets/home_bottom_nav_bar_widget.dart';
import 'package:omni_core/src/app/modules/home/pages/widgets/home_layout_widget.dart';
import 'package:omni_core/src/app/modules/home/pages/widgets/home_nav_bar_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/omni_mediktor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();
  final UserStore userStore = Modular.get();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  final LecuponRepository lecuponRepository = Modular.get();
  final MediktorDiagnosisStore mediktorDiagnosisStore = Modular.get();
  final OmniplanModuleIconStore omniplanModuleIconStore = Modular.get();
  ModuleModel? omniplanModule;
  final UnreadNotificationsCountStore unreadNotificationsStore = Modular.get();

  @override
  void initState() {
    super.initState();

    // unreadNotificationsStore.getUnreadNotificationsCount(userStore.userId);

    store.modulesStore.getActiveModules().then(
      (value) {
        omniplanModuleIconStore.getOmniPlanModuleStatus();
        store.modulesStore.state.any((element) => element.type == ModuleType.mediktor)
            ? mediktorDiagnosisStore.authenticate()
            : null;
      },
    );
    RealLocalNotificationService.initialize();

    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          log('log notification body ${message.notification!.body}');
          log('log notification title ${message.notification!.title}');
        }
        RealLocalNotificationService.display(message);
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // Future<void> refreshModules() async {
  //   store.userStore.getBeneficiaryById(store.userStore.userId);
  //   await store.modulesStore.getActiveModules().then(
  //     (value) {
  //       omniplanModuleIconStore.getOmniPlanModuleStatus();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // lecuponRepository.getAdmminToken().then((administratorUser) {
    //   lecuponRepository
    //       .activeUser(
    //     activeUser: ActivateUserModel(
    //       name: store.userStore.beneficiary.individualPerson?.name,
    //       cpf: store.userStore.beneficiary.individualPerson?.cpf,
    //       email: store.userStore.beneficiary.individualPerson?.user?.email,
    //       phone: store.userStore.beneficiary.individualPerson?.phone,
    //       active: true,
    //     ),
    //   )
    //       .then((activateUser) {
    //     activateUser.cpf = store.userStore.beneficiary.individualPerson?.cpf;
    //     lecuponRepository.registerUser(activateUser: activateUser);
    //   });
    // });
    return Scaffold(
      key: scaffoldKey,
      appBar: const HomeNavBarWidget().createState().build(context) as AppBar,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: const HomeLayoutWidget(),
      bottomNavigationBar: ScopedBuilder<ModulesStore, DioError, List<ModuleModel>>(
        store: store.modulesStore,
        onState: (_, state) {
          return const HomeBottomNavBarWidget();
        },
      ),
    );
  }
}
