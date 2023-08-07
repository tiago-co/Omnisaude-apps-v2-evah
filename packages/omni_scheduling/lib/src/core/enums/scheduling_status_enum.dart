import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omni_scheduling_labels/labels.dart';

enum SchedulingStatus {
  all,
  onApproval,
  approved,
  inService,
  attended,
  canceled,
  notApproved,
  notAttended,
}

extension SchedulingStatusExtension on SchedulingStatus {
  Color get color {
    switch (this) {
      case SchedulingStatus.canceled:
        return const Color(0xFFFF0802);
      case SchedulingStatus.onApproval:
        return const Color(0xFFFFB947);
      case SchedulingStatus.approved:
        return const Color(0xFF00B852);
      case SchedulingStatus.inService:
        return const Color(0xFF00C4FF);
      case SchedulingStatus.attended:
        return const Color(0xFF0090F7);
      case SchedulingStatus.notApproved:
        return const Color(0xFFAA0802);
      case SchedulingStatus.notAttended:
        return const Color(0xFFBDBDBD);
      default:
        return const Color(0xFFBDBDBD);
    }
  }

  String get label {
    switch (this) {
      case SchedulingStatus.canceled:
        return SchedulingLabels.schedulingStatusFilterCanceled;
      case SchedulingStatus.onApproval:
        return SchedulingLabels.schedulingStatusFilterOnApproval;
      case SchedulingStatus.approved:
        return SchedulingLabels.schedulingStatusFilterApproved;
      case SchedulingStatus.inService:
        return SchedulingLabels.schedulingStatusFilterInService;
      case SchedulingStatus.attended:
        return SchedulingLabels.schedulingStatusFilterAttended;
      case SchedulingStatus.notApproved:
        return SchedulingLabels.schedulingStatusFilterNotApproved;
      case SchedulingStatus.notAttended:
        return SchedulingLabels.schedulingStatusFilterNotAttended;
      case SchedulingStatus.all:
        return SchedulingLabels.schedulingStatusFilterAll;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case SchedulingStatus.canceled:
        return 'x';
      case SchedulingStatus.onApproval:
        return 'i';
      case SchedulingStatus.approved:
        return 'c';
      case SchedulingStatus.inService:
        return 'e';
      case SchedulingStatus.attended:
        return 'a';
      case SchedulingStatus.notApproved:
        return 'n';
      case SchedulingStatus.notAttended:
        return 't';
      default:
        return null;
    }
  }
}

SchedulingStatus? schedulingStatusFromJson(String? status) {
  switch (status) {
    case 'x':
      return SchedulingStatus.canceled;
    case 'i':
      return SchedulingStatus.onApproval;
    case 'c':
      return SchedulingStatus.approved;
    case 'e':
      return SchedulingStatus.inService;
    case 'a':
      return SchedulingStatus.attended;
    case 'n':
      return SchedulingStatus.notApproved;
    case 't':
      return SchedulingStatus.notAttended;
    default:
      return null;
  }
}
