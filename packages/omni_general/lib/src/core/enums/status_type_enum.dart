import 'package:omni_general_labels/labels.dart';

enum StatusType { active, inactive }

extension StatusTypeExtension on StatusType {
  String get label {
    switch (this) {
      case StatusType.active:
        return GeneralLabels.statusTypeActive;
      case StatusType.inactive:
        return GeneralLabels.statusTypeInactive;
      default:
        return toString();
    }
  }

  String get toJson {
    switch (this) {
      case StatusType.active:
        return 'a';
      case StatusType.inactive:
        return 'i';
      default:
        return toString();
    }
  }
}

StatusType? statusTypeFromJson(String? type) {
  switch (type) {
    case 'a':
      return StatusType.active;
    case 'i':
      return StatusType.inactive;
    default:
      return null;
  }
}
