import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/enums/biometric_type_enum.dart';

class UseBiometricsStore
    extends NotifierStore<Exception, UseBiometricPermission> {
  final PreferencesService preferencesService = PreferencesService();
  bool canUseBiometricAuth = false;
  BiometricTypeEnum? biometricType;

  UseBiometricsStore() : super(UseBiometricPermission.notAccepted);

  void updateState(UseBiometricPermission useBiometrics) {
    update(useBiometrics);
  }

  Future<UseBiometricPermission> getHasBiometrics() async {
    return preferencesService.getHasBiometrics().then(
      (value) {
        if (value == null) return UseBiometricPermission.notAccepted;
        update(value);
        return value;
      },
    );
  }

  Future<void> canAuthenticateUser() async {
    await LocalAuthService.canAuthenticateUser().then(
      (value) {
        canUseBiometricAuth = value;
        LocalAuthService.getBiometricType().then(
          (value) {
            biometricType = biometricEnumFromBiometricType(value);
          },
        ).catchError(
          (onError) {
            canUseBiometricAuth = false;
          },
        );
      },
    );
  }

  void authenticateWithBiometrics() {
    LocalAuthService.authenticate();
  }

  void changeBiometricPermission(bool hasBiometrics) {
    if (hasBiometrics) {
      update(UseBiometricPermission.accepted);
      preferencesService.setHasBiometrics(UseBiometricPermission.accepted);
    } else {
      update(UseBiometricPermission.denied);
      preferencesService.setHasBiometrics(UseBiometricPermission.denied);
    }
  }
}
