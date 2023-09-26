import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/modules/splash/splash_repository.dart';
import 'package:omni_general/omni_general.dart'
    show
        BeneficiaryRepository,
        FirebaseService,
        Permissions,
        PreferencesModel,
        PreferencesService;
import 'package:omni_general/src/stores/user_store.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashStore extends NotifierStore<DioError, bool> with Disposable {
  final PreferencesService _service = PreferencesService();
  final BeneficiaryRepository _repository = Modular.get();
  final SplashRepository _splashRepository = SplashRepository();
  final FirebaseService firebaseService = Modular.get();
  final ModulesStore modulesStore = Modular.get();
  final ProgramStore programStore = Modular.get();
  final UserStore userStore = Modular.get();
  bool expanded = false;

  SplashStore() : super(false);

  Future<void> getBeneficiaryData() async {
    setLoading(true);

    await firebaseService.setUpFirebase().then((value) {
      firebaseService.onSubscribeToTopic(dotenv.env['POWERED_BY']!);
    }).catchError((onError) {
      log('$onError');
    });

    await _service.getUserID().then((userId) async {
      if (userId == null) throw Exception();

      await _repository.verifyToken(userId).then((jwt) async {
        if (jwt == null) return;
        await _repository
            .refreshToken(userId, jwt.refreshToken!)
            .then((jwt) async {
          final PreferencesModel prefs = PreferencesModel(jwt: jwt);
          await userStore.setUserPreferences(prefs, userId);
        });
        final PreferencesModel prefs = PreferencesModel(jwt: jwt);
        await userStore.setUserPreferences(prefs, userId);
      });

      await userStore.getOperatorConfigs(userId);

      await _service.getUserPreferences(userId).then((prefs) async {
        if (prefs.beneficiary == null) throw Exception();
        expanded = prefs.beneficiary!.isPlanCardExpansive!;
      });

      await userStore.getBeneficiaryById(userId).then((beneficiary) async {
        beneficiary.isPlanCardExpansive = expanded;
        programStore.update(beneficiary.programs!);
        modulesStore.update(
          beneficiary.programSelected!.currentPhase!.modules!,
        );
      });
    }).catchError((onError) async {
      firebaseService.onUnsubscribeFromTopic(userStore.userId);
      await _service.clear();
      await Future.delayed(const Duration(milliseconds: 1500));
      throw onError;
    });

    setLoading(false);
  }

  Future<bool> verifyAppVersion() async {
    final isUpdated = await _splashRepository.verifyAppVersion();
    return isUpdated;
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}

Future<void> getPermissions() async {
  await [
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.camera,
    Permission.microphone,
    Permission.locationAlways,
    Permission.locationWhenInUse,
  ].request().whenComplete(() async {
    await Permissions.notification();
  });
}
