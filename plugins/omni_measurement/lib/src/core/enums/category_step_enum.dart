import 'package:omni_measurement_labels/labels.dart';

enum CategoryStepEnum {
  measurementType,
  measurementMode,
  howAreYouFeeling,
  sendMeasurement,
}

extension CategoryStepEnumExtension on CategoryStepEnum {
  String get label {
    switch (this) {
      case CategoryStepEnum.measurementType:
        return MeasurementLabels.catergoryStepEnumMeasurementType;
      case CategoryStepEnum.measurementMode:
        return MeasurementLabels.catergoryStepEnumMeasurementMode;
      case CategoryStepEnum.howAreYouFeeling:
        return MeasurementLabels.catergoryStepEnumHowAreYouFeeling;
      case CategoryStepEnum.sendMeasurement:
        return MeasurementLabels.catergoryStepEnumSendMeasurement;
    }
  }

  int? get toJson {
    switch (this) {
      case CategoryStepEnum.measurementType:
        return 1;
      case CategoryStepEnum.howAreYouFeeling:
        return 3;
      case CategoryStepEnum.measurementMode:
        return 7;
      default:
        return null;
    }
  }
}

CategoryStepEnum categoryStepEnumFromJson(int? type) {
  switch (type) {
    case 0:
      return CategoryStepEnum.measurementMode;
    case 1:
      return CategoryStepEnum.howAreYouFeeling;
    case 2:
      return CategoryStepEnum.howAreYouFeeling;
    case 3:
      return CategoryStepEnum.sendMeasurement;
    default:
      return CategoryStepEnum.sendMeasurement;
  }
}
