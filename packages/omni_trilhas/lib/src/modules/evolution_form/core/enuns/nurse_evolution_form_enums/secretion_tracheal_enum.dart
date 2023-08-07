enum SecretionTrachealType {
  few,
  average,
  great,
  absentAspiration,
}

extension SecretionTrachealTypeExtension on SecretionTrachealType {
  String get label {
    switch (this) {
      case SecretionTrachealType.few:
        return 'Pouca';
      case SecretionTrachealType.average:
        return 'Média';
      case SecretionTrachealType.great:
        return 'Grande';
      case SecretionTrachealType.absentAspiration:
        return 'Aspiração Ausente';
    }
  }

  String get toJson {
    switch (this) {
      case SecretionTrachealType.few:
        return 'pouca';
      case SecretionTrachealType.average:
        return 'media';
      case SecretionTrachealType.great:
        return 'grande';
      case SecretionTrachealType.absentAspiration:
        return 'aspiracao_ausente';
    }
  }
}

SecretionTrachealType? secretionTrachealTypeFromJson(String? type) {
  switch (type) {
    case 'pouca':
      return SecretionTrachealType.few;
    case 'media':
      return SecretionTrachealType.average;
    case 'grande':
      return SecretionTrachealType.great;
    case 'aspiracao_ausente':
      return SecretionTrachealType.absentAspiration;

    default:
      return null;
  }
}
