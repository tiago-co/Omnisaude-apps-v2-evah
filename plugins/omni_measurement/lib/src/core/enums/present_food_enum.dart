import 'package:omni_measurement_labels/labels.dart';

enum PresentFood {
  prePrandial,
  posPrandial,
  fasting,
  snack,
  bedTime,
  noContext
}

extension PresentFoodExtension on PresentFood {
  String get label {
    switch (this) {
      case PresentFood.prePrandial:
        return MeasurementLabels.presentFoodPrePrandial;
      case PresentFood.posPrandial:
        return MeasurementLabels.presentFoodPosPrandial;
      case PresentFood.fasting:
        return MeasurementLabels.presentFoodFasting;
      case PresentFood.snack:
        return MeasurementLabels.presentFoodSnack;
      case PresentFood.bedTime:
        return MeasurementLabels.presentFoodBedTime;
      case PresentFood.noContext:
        return MeasurementLabels.presentFoodNoContext;
    }
  }

  String get toJson {
    switch (this) {
      case PresentFood.prePrandial:
        return 'Pré-Prandial';
      case PresentFood.posPrandial:
        return 'Pós-Prandial';
      case PresentFood.fasting:
        return 'Jejum';
      case PresentFood.snack:
        return 'Casual';
      case PresentFood.bedTime:
        return 'Antes de dormir';
      case PresentFood.noContext:
        return 'Não informado';
    }
  }
}

PresentFood presentFoodFromInt(int presentFood) {
  switch (presentFood) {
    case 1:
      return PresentFood.prePrandial;
    case 2:
      return PresentFood.posPrandial;
    case 3:
      return PresentFood.fasting;
    case 4:
      return PresentFood.snack;
    case 5:
      return PresentFood.bedTime;
    case 0:
      return PresentFood.noContext;
    default:
      return PresentFood.noContext;
  }
}
