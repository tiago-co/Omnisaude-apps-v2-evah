import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/credential_model.dart';
import 'package:omni_general/src/core/models/new_credential_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> setUserPreferences(PreferencesModel preferences) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString('userId', preferences.jwt!.id!);
        await instance.setString(
          preferences.jwt!.id!,
          jsonEncode(preferences.toJson()),
        );
      },
    );
  }

  Future<void> removeUserPreferences(PreferencesModel preferences) async {
    await SharedPreferences.getInstance().then(
      (instance) {
        instance.remove(preferences.jwt!.id!);
        // instance.remove('userId');
      },
    );
  }

  Future<PreferencesModel> getUserPreferences(String userId) {
    return SharedPreferences.getInstance().then(
      (instance) {
        final String? preferences = instance.getString(userId);
        if (preferences == null) return PreferencesModel();
        return PreferencesModel.fromJson(jsonDecode(preferences));
      },
    );
  }

  Future<String?> getUserID() async {
    return SharedPreferences.getInstance().then(
      (instance) {
        return instance.getString('userId');
      },
    );
  }

  Future<void> setCredential(NewCredentialModel credentials) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString(
          'credential',
          jsonEncode(credentials.toJson()),
        );
      },
    );
  }

  Future<NewCredentialModel> getCredential() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        final String? credential = instance.getString('credential');
        if (credential == null) return NewCredentialModel();
        return NewCredentialModel.fromJson(jsonDecode(credential));
      },
    );
  }

  Future<void> setHasBiometrics(UseBiometricPermission useBiometrics) async {
    final String? userId = await getUserID();
    if (userId == null) return;
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString(
          'hasBiometrics: $userId',
          useBiometricPermissionFromJson(useBiometrics),
        );
      },
    );
  }

  Future<UseBiometricPermission?> getHasBiometrics() async {
    final String? userId = await getUserID();

    return SharedPreferences.getInstance().then(
      (instance) async {
        return useBiometricPermissionFromDevice(
          instance.getString('hasBiometrics: $userId'),
        );
      },
    );
  }

  Future<void> onResumeAppWithBiometrics() async {
    final PreferencesService service = PreferencesService();
    final BeneficiaryRepository repository = Modular.get();
    final AppStateStore appStateStore = Modular.get();

    await service.getUserID().then(
      (userId) async {
        if (userId == null) return;

        await repository.verifyToken(userId).then(
          (jwt) async {
            if (jwt == null) return;
            final bool isBiometricAvaliable = await LocalAuthService.isBiometricAvaliable();
            final bool hasBiometric = await LocalAuthService.hasBiometrics();
            final UseBiometricPermission? biometricPermission = await service.getHasBiometrics();
            appStateStore.updateState(true);
            if (isBiometricAvaliable && hasBiometric && appStateStore.state) {
              if (biometricPermission == UseBiometricPermission.accepted) {
                await LocalAuthService.authenticate().then((value) {}).catchError(
                  (onError) {
                    if (onError.code != 'auth_in_progress') {
                      LogoutService.logout();
                      Modular.to.popUntil(ModalRoute.withName('/'));
                      Modular.to.navigate('/auth/newLogin');
                    }
                  },
                );
              }
              appStateStore.updateState(false);
            }
          },
        );
      },
    );
  }

  Future<void> onPauseApp() async {
    final AppStateStore appStateStore = Modular.get();

    appStateStore.updateState(true);
  }

  Future<bool?> clear() async {
    return SharedPreferences.getInstance().then(
      (instance) {
        return instance.clear();
      },
    );
  }
}
