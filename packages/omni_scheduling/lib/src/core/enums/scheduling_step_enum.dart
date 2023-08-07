import 'package:omni_scheduling_labels/labels.dart';

enum SchedulingStepType {
  schedulingCategory,
  schedulingProfessional,
  schedulingObservation,
}

extension SchedulingStepTypeExtension on SchedulingStepType {
  String get label {
    switch (this) {
      case SchedulingStepType.schedulingCategory:
        return SchedulingLabels.schedulingStepTypeSchedulingCategory;
      case SchedulingStepType.schedulingProfessional:
        return SchedulingLabels.schedulingStepTypeSchedulingProfessional;
      case SchedulingStepType.schedulingObservation:
        return SchedulingLabels.schedulingStepTypeSchedulingObservation;
      // default:
      //   return toString();
    }
  }
}
