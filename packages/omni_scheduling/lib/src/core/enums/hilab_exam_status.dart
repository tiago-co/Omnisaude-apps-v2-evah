import 'package:omni_scheduling_labels/labels.dart';

enum HilabExamStatusType { started, inProgress, waitingResult, finished }

extension HilabExamStatusTypeExtension on HilabExamStatusType {
  String get label {
    switch (this) {
      case HilabExamStatusType.started:
        return SchedulingLabels.hilabExamStatusStarted;
      case HilabExamStatusType.inProgress:
        return SchedulingLabels.hilabExamStatusInProgress;
      case HilabExamStatusType.waitingResult:
        return SchedulingLabels.hilabExamStatusWaitingResult;
      case HilabExamStatusType.finished:
        return SchedulingLabels.hilabExamStatusFinished;
    }
  }
}

HilabExamStatusType? hilabExamStatusTypeFromJson(String? type) {
  switch (type) {
    case 'STARTED':
      return HilabExamStatusType.started;
    case 'IN_PROGRESS':
      return HilabExamStatusType.inProgress;
    case 'WAITING_RESULT':
      return HilabExamStatusType.waitingResult;
    case 'FINISHED':
      return HilabExamStatusType.finished;
    default:
      return null;
  }
}
