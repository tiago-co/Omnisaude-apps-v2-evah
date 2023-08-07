enum HydroairNoiosesType {
  present,
  decreased,
  absent,
}

extension HydroairNoiosesTypeExtension on HydroairNoiosesType {
  String get label {
    switch (this) {
      case HydroairNoiosesType.present:
        return 'Presentes';
      case HydroairNoiosesType.decreased:
        return 'Diminuídos';
      case HydroairNoiosesType.absent:
        return 'Ausentes';
    }
  }

  String get toJson {
    switch (this) {
      case HydroairNoiosesType.present:
        return 'presentes';
      case HydroairNoiosesType.decreased:
        return 'diminuidos';
      case HydroairNoiosesType.absent:
        return 'ausentes';
    }
  }
}

HydroairNoiosesType? hydroairNoiosesTypeFromJson(String? type) {
  switch (type) {
    case 'presentes':
      return HydroairNoiosesType.present;
    case 'diminuidos':
      return HydroairNoiosesType.decreased;
    case 'ausentes':
      return HydroairNoiosesType.absent;
    default:
      return null;
  }
}
