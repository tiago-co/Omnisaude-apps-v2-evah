import 'package:flutter/material.dart';
import 'package:omni_mediktor_labels/labels.dart';

enum MediktorUrgency { veryLow, low, average, high, veryHigh }

extension MediktorUrgencyExtension on MediktorUrgency {
  String get label {
    switch (this) {
      case MediktorUrgency.veryLow:
        return MediktorLabels.mediktorUrgencyVeryLow;
      case MediktorUrgency.low:
        return MediktorLabels.mediktorUrgencyLow;
      case MediktorUrgency.average:
        return MediktorLabels.mediktorUrgencyAverage;
      case MediktorUrgency.high:
        return MediktorLabels.mediktorUrgencyHigh;
      case MediktorUrgency.veryHigh:
        return MediktorLabels.mediktorUrgencyVeryHigh;
    }
  }

  int? get toJson {
    switch (this) {
      case MediktorUrgency.veryLow:
        return 5;
      case MediktorUrgency.low:
        return 4;
      case MediktorUrgency.average:
        return 3;
      case MediktorUrgency.high:
        return 2;
      case MediktorUrgency.veryHigh:
        return 1;
    }
  }

  Color get color {
    switch (this) {
      case MediktorUrgency.veryLow:
        return Colors.green;
      case MediktorUrgency.low:
        return Colors.green.withOpacity(0.5);
      case MediktorUrgency.average:
        return Colors.blue.withOpacity(0.5);
      case MediktorUrgency.high:
        return Colors.red.withOpacity(0.5);
      case MediktorUrgency.veryHigh:
        return Colors.red;
    }
  }
}

MediktorUrgency? mediktorUrgencyFromJson(int? urgency) {
  switch (urgency) {
    case 5:
      return MediktorUrgency.veryLow;
    case 4:
      return MediktorUrgency.low;
    case 3:
      return MediktorUrgency.average;
    case 2:
      return MediktorUrgency.high;
    case 1:
      return MediktorUrgency.veryHigh;
    default:
      return null;
  }
}
