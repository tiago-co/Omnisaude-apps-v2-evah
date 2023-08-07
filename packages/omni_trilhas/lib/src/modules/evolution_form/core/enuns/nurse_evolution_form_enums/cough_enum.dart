enum CoughType { effective, notEffective, absent }

extension CoughTypeExtension on CoughType {
  String get label {
    switch (this) {
      case CoughType.effective:
        return 'Eficaz';
      case CoughType.notEffective:
        return 'Não Eficaz';
      case CoughType.absent:
        return 'Ausente';
    }
  }

  String get toJson {
    switch (this) {
      case CoughType.effective:
        return 'eficaz';
      case CoughType.notEffective:
        return 'nao_eficaz';
      case CoughType.absent:
        return 'ausente';
    }
  }
}

CoughType? coughTypeFromJson(String? type) {
  switch (type) {
    case 'eficaz':
      return CoughType.effective;
    case 'nao_eficaz':
      return CoughType.notEffective;
    case 'ausente':
      return CoughType.absent;
    default:
      return null;
  }
}
