enum AuscultateType {
  murmursVesicular,
  lungsFree,
  snoring,
  wheezes,
  rales,
}

extension AuscultateTypeExtension on AuscultateType {
  String get label {
    switch (this) {
      case AuscultateType.murmursVesicular:
        return 'Murmúrios Vesiculares';
      case AuscultateType.lungsFree:
        return 'Pulmões Livres';
      case AuscultateType.snoring:
        return 'Roncos';
      case AuscultateType.wheezes:
        return 'Sibilos';
      case AuscultateType.rales:
        return 'Estertores';
    }
  }

  String get toJson {
    switch (this) {
      case AuscultateType.murmursVesicular:
        return 'murmurios_vesiculares';
      case AuscultateType.lungsFree:
        return 'pulmoes_livres';
      case AuscultateType.snoring:
        return 'roncos';
      case AuscultateType.wheezes:
        return 'sibilos';
      case AuscultateType.rales:
        return 'estertores';
    }
  }
}

AuscultateType? auscultateTypeFromJson(String? type) {
  switch (type) {
    case 'murmurios_vesiculares':
      return AuscultateType.murmursVesicular;
    case 'pulmoes_livres':
      return AuscultateType.lungsFree;
    case 'roncos':
      return AuscultateType.snoring;
    case 'sibilos':
      return AuscultateType.wheezes;
    case 'estertores':
      return AuscultateType.rales;
    default:
      return null;
  }
}
