enum GeneralType {
  plan,
  globose,
  excavated,
  recentSurgery,
  colostomy,
  ilestomy,
  jejunostomy,
}

extension GeneralTypeExtension on GeneralType {
  String get label {
    switch (this) {
      case GeneralType.plan:
        return 'Plano';
      case GeneralType.globose:
        return 'Globoso';
      case GeneralType.excavated:
        return 'Escavado';
      case GeneralType.recentSurgery:
        return 'Cirurgia Recente';
      case GeneralType.colostomy:
        return 'Colostomia';
      case GeneralType.ilestomy:
        return 'Ilestomia';
      case GeneralType.jejunostomy:
        return 'Jejustonomia';
    }
  }

  String get toJson {
    switch (this) {
      case GeneralType.plan:
        return 'plano';
      case GeneralType.globose:
        return 'globoso';
      case GeneralType.excavated:
        return 'escavado';
      case GeneralType.recentSurgery:
        return 'cirurgia_recente';
      case GeneralType.colostomy:
        return 'colostomia';
      case GeneralType.ilestomy:
        return 'ilestomia';
      case GeneralType.jejunostomy:
        return 'jejunostomia';
    }
  }
}

GeneralType? generalTypeFromJson(String? type) {
  switch (type) {
    case 'plano':
      return GeneralType.plan;
    case 'globoso':
      return GeneralType.globose;
    case 'escavado':
      return GeneralType.excavated;
    case 'cirurgia_recente':
      return GeneralType.recentSurgery;
    case 'colostomia':
      return GeneralType.colostomy;
    case 'ilestomia':
      return GeneralType.ilestomy;
    case 'jejunostomia':
      return GeneralType.jejunostomy;
    default:
      return null;
  }
}
