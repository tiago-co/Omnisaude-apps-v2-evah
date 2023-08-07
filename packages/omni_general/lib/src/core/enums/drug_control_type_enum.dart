import 'package:omni_general_labels/labels.dart';

enum DrugControlType { primaryBase, primaryRegistered, secondary }

extension DrugControlTypeExtension on DrugControlType {
  String get label {
    switch (this) {
      case DrugControlType.primaryBase:
        return GeneralLabels.drugControlTypePrimaryBase;
      case DrugControlType.primaryRegistered:
        return GeneralLabels.drugControlTypePrimaryRegistered;
      case DrugControlType.secondary:
        return GeneralLabels.drugControlTypeSecondary;
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

DrugControlType? drugControlTypeFromJson(String? drugControlType) {
  switch (drugControlType) {
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
