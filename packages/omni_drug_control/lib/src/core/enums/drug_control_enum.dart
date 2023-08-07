import 'package:omni_drug_control_labels/labels.dart';

enum DrugControlType { primaryBase, primaryRegistered, secondary }

extension DrugControlTypeExtension on DrugControlType {
  String get label {
    switch (this) {
      case DrugControlType.primaryBase:
        return DrugControlLabels.drugControlTypePrimaryBase;
      case DrugControlType.primaryRegistered:
        return DrugControlLabels.drugControlTypePrimaryRegistered;
      case DrugControlType.secondary:
        return DrugControlLabels.drugControlTypeSecondary;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case DrugControlType.primaryBase:
        return 'pc';
      case DrugControlType.primaryRegistered:
        return 'pb';
      case DrugControlType.secondary:
        return 'sc';
      default:
        return null;
    }
  }
}

DrugControlType? drugControlTypeFromJson(String? type) {
  switch (type) {
    case 'pc':
      return DrugControlType.primaryBase;
    case 'pb':
      return DrugControlType.primaryRegistered;
    case 'sc':
      return DrugControlType.secondary;
    default:
      return null;
  }
}
