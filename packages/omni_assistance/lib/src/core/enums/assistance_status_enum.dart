import 'package:flutter/material.dart';
import 'package:omni_assistance_labels/labels.dart';

enum AssistanceStatus {
  all,
  open,
  solved,
}

extension AssistanceStatusExtension on AssistanceStatus {
  Color get color {
    switch (this) {
      case AssistanceStatus.open:
        return const Color(0xFFFFB947);
      case AssistanceStatus.solved:
        return const Color(0xFF00B852);
      default:
        return const Color(0xFFBDBDBD);
    }
  }

  String get label {
    switch (this) {
      case AssistanceStatus.all:
        return AssistanceLabels.assistancePageStatusAll;
      case AssistanceStatus.open:
        return AssistanceLabels.assistancePageStatusOpen;
      case AssistanceStatus.solved:
        return AssistanceLabels.assistancePageStatusSolved;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case AssistanceStatus.open:
        return 'aberto';
      case AssistanceStatus.solved:
        return 'resolvido';
      default:
        return null;
    }
  }
}

AssistanceStatus? assistanceStatusFromJson(String? status) {
  switch (status) {
    case 'aberto':
      return AssistanceStatus.open;
    case 'resolvido':
      return AssistanceStatus.solved;
    default:
      return null;
  }
}
