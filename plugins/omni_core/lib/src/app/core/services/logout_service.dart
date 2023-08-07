import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show
        FirebaseService,
        PreferencesService,
        UseBiometricPermission,
        UseBiometricsStore;
import 'package:omni_general/src/stores/user_store.dart';

class LogoutService {
  static Future<void> deactivateBiometricAuth() async {
    final PreferencesService preferencesService = PreferencesService();
    await preferencesService
        .setHasBiometrics(UseBiometricPermission.notAccepted);
  }

  static Future<void> logout() async {
    final UserStore userStore = Modular.get();
    final FirebaseService firebaseService = Modular.get();
    final PreferencesService service = PreferencesService();

    firebaseService.onUnsubscribeFromTopic(userStore.userId);
    firebaseService.onUnsubscribeFromTopic(dotenv.env['POWERED_BY']!);

    userStore.state.primaryColor = null;
    await service.setUserPreferences(userStore.state);
    await userStore.setUserPreferences(userStore.state, userStore.userId);
    await userStore.updateUser();
    service.removeUserPreferences(userStore.state);
    Modular.to.popUntil(ModalRoute.withName('/'));
    Modular.to.navigate('/presentation/letsGo');
  }
}
