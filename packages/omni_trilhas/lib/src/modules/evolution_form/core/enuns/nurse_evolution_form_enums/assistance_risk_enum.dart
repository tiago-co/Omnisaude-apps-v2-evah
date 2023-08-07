enum AssistanceRiskType {
  fall,
  venousThrombosis,
  bleeding,
  delirium,
  allergy,
}

extension AssistanceRiskTypeExtension on AssistanceRiskType {
  String get label {
    switch (this) {
      case AssistanceRiskType.fall:
        return 'Queda';
      case AssistanceRiskType.venousThrombosis:
        return 'Trombose Venosa';
      case AssistanceRiskType.bleeding:
        return 'Sangramento';
      case AssistanceRiskType.delirium:
        return 'Delirium';
      case AssistanceRiskType.allergy:
        return 'Alergia';
    }
  }

  String get toJson {
    switch (this) {
      case AssistanceRiskType.fall:
        return 'queda';
      case AssistanceRiskType.venousThrombosis:
        return 'trombose_venosa';
      case AssistanceRiskType.bleeding:
        return 'sangramento';
      case AssistanceRiskType.delirium:
        return 'delirium';
      case AssistanceRiskType.allergy:
        return 'alergia';
    }
  }
}

AssistanceRiskType? assistanceRiskTypeFromJson(String? type) {
  switch (type) {
    case 'queda':
      return AssistanceRiskType.fall;
    case 'trombose_venosa':
      return AssistanceRiskType.venousThrombosis;
    case 'sangramento':
      return AssistanceRiskType.bleeding;
    case 'delirium':
      return AssistanceRiskType.delirium;
    case 'alergia':
      return AssistanceRiskType.allergy;
    default:
      return null;
  }
}
