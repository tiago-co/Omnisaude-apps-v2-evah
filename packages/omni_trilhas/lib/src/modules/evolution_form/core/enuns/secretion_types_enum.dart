enum SecretionTypes { absent, hyaline, thick, lots }

extension SecretionTypesExtension on SecretionTypes {
  String get label {
    switch (this) {
      case SecretionTypes.absent:
        return 'Ausente';
      case SecretionTypes.hyaline:
        return 'Hialina';
      case SecretionTypes.thick:
        return 'Espessa';
      case SecretionTypes.lots:
        return 'Grande quantidade';
    }
  }

  String get toJson {
    switch (this) {
      case SecretionTypes.absent:
        return 'ausente';
      case SecretionTypes.hyaline:
        return 'hialina';
      case SecretionTypes.thick:
        return 'espessa';
      case SecretionTypes.lots:
        return 'grande_quantidade';
    }
  }
}

SecretionTypes? secretionTypesFromJson(String? type) {
  switch (type) {
    case 'ausente':
      return SecretionTypes.absent;
    case 'hialina':
      return SecretionTypes.hyaline;
    case 'espessa':
      return SecretionTypes.thick;
    case 'grande_quantidade':
      return SecretionTypes.lots;
    default:
      return null;
  }
}
