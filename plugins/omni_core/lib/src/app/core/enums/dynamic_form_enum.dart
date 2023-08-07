import 'package:extra_data_labels/labels.dart';

enum DynamicFormStatus { answered, pending, }

extension DynamicFormStatusExtension on DynamicFormStatus {
  String get label {
    switch (this) {
      case DynamicFormStatus.answered:
        return ExtraDataLabels.dynamicFormStatusAnswered;
      case DynamicFormStatus.pending:
        return ExtraDataLabels.dynamicFormStatusPending;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case DynamicFormStatus.answered:
        return 'r';
      case DynamicFormStatus.pending:
        return 'p';
      default:
        return null;
    }
  }
}

DynamicFormStatus? dynamicFormStatusFromJson(String? status) {
  switch (status) {
    case 'r':
      return DynamicFormStatus.answered;
    case 'p':
      return DynamicFormStatus.pending;
    default:
      return null;
  }
}
