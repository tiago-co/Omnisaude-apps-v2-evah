import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

// ignore: avoid_classes_with_only_static_members
class LocalAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometricType() async {
    final List<BiometricType> list = await _auth.getAvailableBiometrics();
    return list;
  }

  static Future<bool> isBiometricAvaliable() async {
    return _auth.isDeviceSupported();
  }

  static Future<bool> canAuthenticateUser() async {
    final biometricType = await getBiometricType();
    final hasBiometric = await hasBiometrics();
    final isDeviceSupported = await _auth.isDeviceSupported();
    if (biometricType.isNotEmpty) {
      return (hasBiometric || isDeviceSupported) &&
          (biometricType.first == BiometricType.fingerprint ||
              biometricType.first == BiometricType.weak ||
              biometricType.first == BiometricType.strong);
    } else {
      return false;
      // throw PlatformException(code: 'None Biometric Type');
    }
  }

  static Future<bool> authenticate() async {
    final canAuthenticate = await canAuthenticateUser();
    if (!canAuthenticate) return false;
    try {
      return _auth.authenticate(
        localizedReason: 'Utilize sua biometria para entrar',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Oops! Autenticação por biometria requerida!',
            biometricHint: 'Faça a autenticação',
            biometricSuccess: 'Autenticação realizada com sucesso!',
          ),
        ],
        options: const AuthenticationOptions(
          sensitiveTransaction: false,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}
