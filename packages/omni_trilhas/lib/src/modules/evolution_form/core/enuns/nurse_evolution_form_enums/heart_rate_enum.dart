enum HeartRateType {
  normocardia,
  bradycardia,
  tachycardia,
}

extension HeartRateTypeExtension on HeartRateType {
  String get label {
    switch (this) {
      case HeartRateType.normocardia:
        return 'Normocardio';
      case HeartRateType.bradycardia:
        return 'Bradicardico';
      case HeartRateType.tachycardia:
        return 'Taquicardio';
    }
  }

  String get toJson {
    switch (this) {
      case HeartRateType.normocardia:
        return 'normocardio';
      case HeartRateType.bradycardia:
        return 'bradicardico';
      case HeartRateType.tachycardia:
        return 'taquicardio';
    }
  }
}

HeartRateType? heartRateTypeFromJson(String? type) {
  switch (type) {
    case 'normocardio':
      return HeartRateType.normocardia;
    case 'bradicardico':
      return HeartRateType.bradycardia;
    case 'taquicardio':
      return HeartRateType.tachycardia;
    default:
      return null;
  }
}
