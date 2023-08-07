import 'package:omni_measurement_labels/labels.dart';

enum MealType {
  prePrandial,
  posPrandial,
  emJejum,
  aoDeitar,
  indefinido,
}

extension MealModeExtension on MealType {
  String get label {
    switch (this) {
      case MealType.prePrandial:
        return MeasurementLabels.mealTypePrePrandial;
      case MealType.posPrandial:
        return MeasurementLabels.mealTypePosPrandial;
      case MealType.emJejum:
        return MeasurementLabels.mealTypeEmJejum;
      case MealType.aoDeitar:
        return MeasurementLabels.mealTypeAoDeitar;
      case MealType.indefinido:
        return MeasurementLabels.mealTypeIndefinido;
    }
  }

  String? get toJson {
    switch (this) {
      case MealType.prePrandial:
        return 'pre prandial';
      case MealType.posPrandial:
        return 'pos prandial';
      case MealType.emJejum:
        return 'em jejum';
      case MealType.aoDeitar:
        return 'ao deitar';
      case MealType.indefinido:
        return '';
    }
  }
}

MealType? mealTypeFromJson(String? type) {
  switch (type) {
    case 'pre prandial':
      return MealType.prePrandial;
    case 'pos prandial':
      return MealType.posPrandial;
    case 'em jejum':
      return MealType.emJejum;
    case 'ao deitar':
      return MealType.aoDeitar;
  }
  return null;
}
