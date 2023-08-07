enum ToneType {
  sagging,
  rigidity,
  legsFlexion,
  activeMoves,
}

extension ToneTypeExtension on ToneType {
  String get label {
    switch (this) {
      case ToneType.sagging:
        return 'Flacidez';
      case ToneType.rigidity:
        return 'Rigidez';
      case ToneType.legsFlexion:
        return 'Flexão de Pernas e Braços';
      case ToneType.activeMoves:
        return 'Movimentos Ativos';
    }
  }

  String get toJson {
    switch (this) {
      case ToneType.sagging:
        return 'flacidez';
      case ToneType.rigidity:
        return 'rigidez';
      case ToneType.legsFlexion:
        return 'flexao_de_pernas';
      case ToneType.activeMoves:
        return 'movimentos_ativos';
    }
  }
}

ToneType? toneTypeFromJson(String? type) {
  switch (type) {
    case 'flacidez':
      return ToneType.sagging;
    case 'rigidez':
      return ToneType.rigidity;
    case 'flexao_de_pernas':
      return ToneType.legsFlexion;
    case 'movimentos_ativos':
      return ToneType.activeMoves;
    default:
      return null;
  }
}
