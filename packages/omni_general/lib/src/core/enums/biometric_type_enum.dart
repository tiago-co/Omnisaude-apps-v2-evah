import 'package:local_auth/local_auth.dart';

enum BiometricTypeEnum { face, fingerprint }

extension BiometricTypeTypeExtension on BiometricTypeEnum {
  String get androidLabel {
    switch (this) {
      case BiometricTypeEnum.face:
        return 'Android Face';
      case BiometricTypeEnum.fingerprint:
        return 'Android Biometric';
      default:
        return toString();
    }
  }

  String get iOSLabel {
    switch (this) {
      case BiometricTypeEnum.face:
        return 'Face Id';
      case BiometricTypeEnum.fingerprint:
        return 'TouchId';
      default:
        return toString();
    }
  }

  String? get androidAsset {
    switch (this) {
      case BiometricTypeEnum.face:
        return 'assets/biometrics/android_face.svg';
      case BiometricTypeEnum.fingerprint:
        return 'assets/biometrics/android_fingerprint.svg';
      default:
        return 'assets/biometrics/fingerprint.svg';
    }
  }

  String get iOSAsset {
    switch (this) {
      case BiometricTypeEnum.face:
        return 'assets/biometrics/face_id.svg';
      case BiometricTypeEnum.fingerprint:
        return 'assets/biometrics/touch_id.svg';
      default:
        return 'assets/biometrics/fingerprint.svg';
    }
  }
}

BiometricTypeEnum? biometricEnumFromBiometricType(
  BiometricType? biometricType,
) {
  switch (biometricType) {
    case BiometricType.face:
      return BiometricTypeEnum.face;
    case BiometricType.fingerprint:
      return BiometricTypeEnum.fingerprint;

    default:
      return BiometricTypeEnum.fingerprint;
  }
}
