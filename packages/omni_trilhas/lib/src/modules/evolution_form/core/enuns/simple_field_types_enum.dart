enum SimpleFieldTypes {
  medicalImpression,
  therapeuticPlan,
  medicalConduct,
  overallImpression
}

extension SimpleFieldTypesExtension on SimpleFieldTypes {
  String get label {
    switch (this) {
      case SimpleFieldTypes.medicalImpression:
        return 'Impressão Médica';
      case SimpleFieldTypes.therapeuticPlan:
        return 'Plano Terapêutico';
      case SimpleFieldTypes.medicalConduct:
        return 'Conduta Médica';
      case SimpleFieldTypes.overallImpression:
        return 'Impressão Geral';
    }
  }

  String get toJson {
    switch (this) {
      case SimpleFieldTypes.medicalImpression:
        return 'impressao_medica';
      case SimpleFieldTypes.therapeuticPlan:
        return 'plano_terapeutico';
      case SimpleFieldTypes.medicalConduct:
        return 'conduta_medica';
      case SimpleFieldTypes.overallImpression:
        return 'impressao_geral';
    }
  }
}

SimpleFieldTypes? simpleFieldTypesFromJson(String? type) {
  switch (type) {
    case 'impressao_medica':
      return SimpleFieldTypes.medicalImpression;
    case 'plano_terapeutico':
      return SimpleFieldTypes.therapeuticPlan;
    case 'conduta_medica':
      return SimpleFieldTypes.medicalConduct;
    case 'impressao_geral':
      return SimpleFieldTypes.overallImpression;
    default:
      return null;
  }
}
