import 'package:omni_general_labels/labels.dart';

enum MaritalStatus { single, married, divorced, widower, separate }

extension MaritalStatusExtension on MaritalStatus {
  String? get label {
    switch (this) {
      case MaritalStatus.single:
        return GeneralLabels.maritalStatusSingle;
      case MaritalStatus.married:
        return GeneralLabels.maritalStatusMarried;
      case MaritalStatus.divorced:
        return GeneralLabels.maritalStatusDivorced;
      case MaritalStatus.widower:
        return GeneralLabels.maritalStatusWidower;
      case MaritalStatus.separate:
        return GeneralLabels.maritalStatusSeparate;
    }
  }

  String? get toJson {
    switch (this) {
      case MaritalStatus.single:
        return 'solteiro';
      case MaritalStatus.married:
        return 'casado';
      case MaritalStatus.divorced:
        return 'divorciado';
      case MaritalStatus.widower:
        return 'viuvo';
      case MaritalStatus.separate:
        return 'separado';
      default:
        return null;
    }
  }
}

MaritalStatus? maritalStatusFromJson(String? status) {
  switch (status) {
    case 'solteiro':
      return MaritalStatus.single;
    case 'casado':
      return MaritalStatus.married;
    case 'divorciado':
      return MaritalStatus.divorced;
    case 'viuvo':
      return MaritalStatus.widower;
    case 'separado':
      return MaritalStatus.separate;
    default:
      return null;
  }
}
