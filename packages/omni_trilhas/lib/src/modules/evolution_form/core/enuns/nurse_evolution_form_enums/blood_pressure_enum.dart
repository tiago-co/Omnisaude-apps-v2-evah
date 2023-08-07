enum BloodPressureType {
  normotensive,
  hypotension,
  hypertension,
  unstable,
}

extension BloodPressureTypeExtension on BloodPressureType {
  String get label {
    switch (this) {
      case BloodPressureType.normotensive:
        return 'Normotenso';
      case BloodPressureType.hypotension:
        return 'Hipotensão';
      case BloodPressureType.hypertension:
        return 'Hipertensão';
      case BloodPressureType.unstable:
        return 'Instável Hemodinamicamente';
    }
  }

  String get toJson {
    switch (this) {
      case BloodPressureType.normotensive:
        return 'normotenso';
      case BloodPressureType.hypotension:
        return 'hipotensao';
      case BloodPressureType.hypertension:
        return 'hipertensao';
      case BloodPressureType.unstable:
        return 'instavel';
    }
  }
}

BloodPressureType? bloodPressureTypeFromJson(String? type) {
  switch (type) {
    case 'normotenso':
      return BloodPressureType.normotensive;
    case 'hipotensao':
      return BloodPressureType.hypotension;
    case 'hipertensao':
      return BloodPressureType.hypertension;
    case 'instavel':
      return BloodPressureType.unstable;
    default:
      return null;
  }
}
