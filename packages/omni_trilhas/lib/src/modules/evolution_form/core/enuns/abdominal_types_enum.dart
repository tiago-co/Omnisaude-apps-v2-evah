enum AbdominalTypes {
  abdomenFlaccidWithoutChanges,
  gastrostomy,
  nasoenteraltube,
  dietOralReasonableAcceptance,
  dietOralLowAcceptance,
}

extension AbdominalTypesExtension on AbdominalTypes {
  String get label {
    switch (this) {
      case AbdominalTypes.abdomenFlaccidWithoutChanges:
        return 'Abdome flácido sem alterações';
      case AbdominalTypes.gastrostomy:
        return 'Gastrostomia';
      case AbdominalTypes.nasoenteraltube:
        return 'Sonda nasoenteral';
      case AbdominalTypes.dietOralReasonableAcceptance:
        return '"Dieta via oral razoável aceitação';
      case AbdominalTypes.dietOralLowAcceptance:
        return 'Dieta via oral com baixa aceitação';
    }
  }

  String get toJson {
    switch (this) {
      case AbdominalTypes.abdomenFlaccidWithoutChanges:
        return 'abdome_flacido_sem_alteracoes';
      case AbdominalTypes.gastrostomy:
        return 'gastrostomia';
      case AbdominalTypes.nasoenteraltube:
        return 'sonda_nasoenteral';
      case AbdominalTypes.dietOralReasonableAcceptance:
        return 'dieta_oral_razoavel_aceitacao';
      case AbdominalTypes.dietOralLowAcceptance:
        return 'dieta_oral_baixa_aceitacao';
    }
  }
}

AbdominalTypes? abdominalTypesFromJson(String? type) {
  switch (type) {
    case 'abdome_flacido_sem_alteracoes':
      return AbdominalTypes.abdomenFlaccidWithoutChanges;
    case 'gastrostomia':
      return AbdominalTypes.gastrostomy;
    case 'sonda_nasoenteral':
      return AbdominalTypes.nasoenteraltube;
    case 'dieta_oral_razoavel_aceitacao':
      return AbdominalTypes.dietOralLowAcceptance;
    case 'dieta_oral_baixa_aceitacao':
      return AbdominalTypes.dietOralLowAcceptance;
    default:
      return null;
  }
}
