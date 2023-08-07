import 'package:omni_measurement_labels/labels.dart';

enum MeasurementStepType {
  measurementType,
  measurementMode,
  measurement,
  howAreYouFeeling,
}

extension MeasurementStepTypeExtension on MeasurementStepType {
  String get label {
    switch (this) {
      case MeasurementStepType.measurementType:
        return MeasurementLabels.measurementStepTypeMeasurementType;
      case MeasurementStepType.measurementMode:
        return MeasurementLabels.measurementStepTypeMeasurementMode;
      case MeasurementStepType.measurement:
        return MeasurementLabels.measurementStepTypeMeasurement;
      case MeasurementStepType.howAreYouFeeling:
        return MeasurementLabels.measurementStepTypeHowAreYouFeeling;
      default:
        return toString();
    }
  }
}

MeasurementStepType? measurementStepTypeLabel(int type) {
  switch (type) {
    case 0:
      return MeasurementStepType.measurementType;
    case 1:
      return MeasurementStepType.measurementMode;
    case 2:
      return MeasurementStepType.measurement;
    case 3:
      return MeasurementStepType.howAreYouFeeling;
    default:
      return null;
  }
}
