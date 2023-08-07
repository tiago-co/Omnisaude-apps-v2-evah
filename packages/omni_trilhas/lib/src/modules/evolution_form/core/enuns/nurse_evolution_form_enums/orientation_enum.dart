enum OrientationType {
  active,
  sleepy,
  torporous,
  comatose,
  reactive,
}

extension OrientationTypeExtension on OrientationType {
  String get label {
    switch (this) {
      case OrientationType.active:
        return 'Ativo';
      case OrientationType.sleepy:
        return 'Sonolento';
      case OrientationType.torporous:
        return 'Torporoso';
      case OrientationType.comatose:
        return 'Comatoso';
      case OrientationType.reactive:
        return 'Reativo';
    }
  }

  String get toJson {
    switch (this) {
      case OrientationType.active:
        return 'ativo';
      case OrientationType.sleepy:
        return 'sonolento';
      case OrientationType.torporous:
        return 'torporoso';
      case OrientationType.comatose:
        return 'comatoso';
      case OrientationType.reactive:
        return 'reativo';
    }
  }
}

OrientationType? orientationTypeFromJson(String? type) {
  switch (type) {
    case 'ativo':
      return OrientationType.active;
    case 'sonolento':
      return OrientationType.sleepy;
    case 'torporoso':
      return OrientationType.torporous;
    case 'comatoso':
      return OrientationType.comatose;
    case 'reativo':
      return OrientationType.reactive;
    default:
      return null;
  }
}
