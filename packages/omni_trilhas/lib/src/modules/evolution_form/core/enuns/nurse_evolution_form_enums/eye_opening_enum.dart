enum EyeOpeningType {
  spontaneous,
  onCommand,
  thePain,
  none,
}

extension EyeOpeningTypeExtension on EyeOpeningType {
  String get label {
    switch (this) {
      case EyeOpeningType.spontaneous:
        return 'Espontânea';
      case EyeOpeningType.onCommand:
        return 'Ao Comando';
      case EyeOpeningType.thePain:
        return 'A Dor';
      case EyeOpeningType.none:
        return 'Nenhuma';
    }
  }

  String get toJson {
    switch (this) {
      case EyeOpeningType.spontaneous:
        return 'espontanea';
      case EyeOpeningType.onCommand:
        return 'ao_comando';
      case EyeOpeningType.thePain:
        return 'a_dor';
      case EyeOpeningType.none:
        return 'nenhuma';
    }
  }
}

EyeOpeningType? eyeOpeningTypeFromJson(String? type) {
  switch (type) {
    case 'espontanea':
      return EyeOpeningType.spontaneous;
    case 'ao_comando':
      return EyeOpeningType.onCommand;
    case 'a_dor':
      return EyeOpeningType.thePain;
    case 'nenhuma':
      return EyeOpeningType.none;
    default:
      return null;
  }
}
