import 'package:omni_scheduling_labels/labels.dart';

enum SchedulingType { presential, teleAttendance }

extension SchedulingTypeExtension on SchedulingType {
  String get label {
    switch (this) {
      case SchedulingType.presential:
        return SchedulingLabels.schedulingTypePresential;
      case SchedulingType.teleAttendance:
        return SchedulingLabels.schedulingTypeTeleAttendance;
      default:
        return toString();
    }
  }

   String? get toJson {
    switch (this) {
      case SchedulingType.presential:
        return 'p';
      case SchedulingType.teleAttendance:
        return 't';
      default:
        return null;
    }
  }

  String get asset {
    switch (this) {
      case SchedulingType.presential:
        return 'assets/icons/presential.svg';
      case SchedulingType.teleAttendance:
        return 'assets/icons/teleattendance.svg';
      default:
        return 'assets/icons/teleattendance.svg';
    }
  }
}

SchedulingType? schedulingTypeFromJson(String? type) {
  switch (type) {
    case 'p':
      return SchedulingType.presential;
    case 't':
      return SchedulingType.teleAttendance;
    default:
      return null;
  }
}
