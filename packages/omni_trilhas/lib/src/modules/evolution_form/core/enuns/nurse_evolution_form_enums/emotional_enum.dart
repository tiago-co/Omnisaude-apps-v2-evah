enum EmotionalType {
  calm,
  agitated,
  aggressive,
  lethargic,
  nsa,
}

extension EmotionalTypeExtension on EmotionalType {
  String get label {
    switch (this) {
      case EmotionalType.calm:
        return 'Calmo';
      case EmotionalType.agitated:
        return 'Agitado';
      case EmotionalType.aggressive:
        return 'Agressivo';
      case EmotionalType.lethargic:
        return 'Letárgico';
      case EmotionalType.nsa:
        return 'NSA';
    }
  }

  String get toJson {
    switch (this) {
      case EmotionalType.calm:
        return 'calmo';
      case EmotionalType.agitated:
        return 'agitado';
      case EmotionalType.aggressive:
        return 'agressivo';
      case EmotionalType.lethargic:
        return 'letargico';
      case EmotionalType.nsa:
        return 'nsa';
    }
  }
}

EmotionalType? emotionalTypeFromJson(String? type) {
  switch (type) {
    case 'calmo':
      return EmotionalType.calm;
    case 'agitado':
      return EmotionalType.agitated;
    case 'agressivo':
      return EmotionalType.aggressive;
    case 'letargico':
      return EmotionalType.lethargic;
    case 'nsa':
      return EmotionalType.nsa;
    default:
      return null;
  }
}
