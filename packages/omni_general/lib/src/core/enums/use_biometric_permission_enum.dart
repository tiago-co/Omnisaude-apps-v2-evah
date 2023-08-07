import 'package:omni_general_labels/labels.dart';

enum UseBiometricPermission { accepted, notAccepted, denied }

extension UseBiometricPermissionExtension on UseBiometricPermission {
  String get label {
    switch (this) {
      case UseBiometricPermission.accepted:
        return GeneralLabels.useBiometricPermissionAccepted;
      case UseBiometricPermission.notAccepted:
        return GeneralLabels.useBiometricPermissionNotAccepted;
      case UseBiometricPermission.denied:
        return GeneralLabels.useBiometricPermissionDenied;
      default:
        return toString();
    }
  }
}

UseBiometricPermission? useBiometricPermissionFromDevice(String? permission) {
  switch (permission) {
    case 'accepted':
      return UseBiometricPermission.accepted;
    case 'notAccepted':
      return UseBiometricPermission.notAccepted;
    case 'denied':
      return UseBiometricPermission.denied;
    default:
      return UseBiometricPermission.notAccepted;
  }
}

String useBiometricPermissionFromJson(UseBiometricPermission? permission) {
  switch (permission) {
    case UseBiometricPermission.accepted:
      return 'accepted';
    case UseBiometricPermission.notAccepted:
      return 'notAccepted';
    case UseBiometricPermission.denied:
      return 'denied';
    default:
      return 'notAccepted';
  }
}
