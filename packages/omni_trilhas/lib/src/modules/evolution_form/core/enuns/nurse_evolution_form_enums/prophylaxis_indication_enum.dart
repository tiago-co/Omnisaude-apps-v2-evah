enum ProphylaxisIndicationType {
  dva,
  tce,
  avc,
  burnt,
  fastingProlonged,
  notRecommended,
  therapeutic,
  vmMore72h,
}

extension ProphylaxisIndicationTypeExtension on ProphylaxisIndicationType {
  String get label {
    switch (this) {
      case ProphylaxisIndicationType.dva:
        return 'DVA';
      case ProphylaxisIndicationType.tce:
        return 'TCE';
      case ProphylaxisIndicationType.avc:
        return 'AVC';
      case ProphylaxisIndicationType.burnt:
        return 'Queimado';
      case ProphylaxisIndicationType.fastingProlonged:
        return 'Jejum Prolongado';
      case ProphylaxisIndicationType.notRecommended:
        return 'Não indicado';
      case ProphylaxisIndicationType.therapeutic:
        return 'Terapêutico';
      case ProphylaxisIndicationType.vmMore72h:
        return 'VM por mais de 72hs';
    }
  }

  String get toJson {
    switch (this) {
      case ProphylaxisIndicationType.dva:
        return 'dva';
      case ProphylaxisIndicationType.tce:
        return 'tce';
      case ProphylaxisIndicationType.avc:
        return 'avc';
      case ProphylaxisIndicationType.burnt:
        return 'queimado';
      case ProphylaxisIndicationType.fastingProlonged:
        return 'jejum_prolongado';
      case ProphylaxisIndicationType.notRecommended:
        return 'nao_indicado';
      case ProphylaxisIndicationType.therapeutic:
        return 'terapeutico';
      case ProphylaxisIndicationType.vmMore72h:
        return 'vm_mais_72h';
    }
  }
}

ProphylaxisIndicationType? prophylaxisIndicationTypeFromJson(String? type) {
  switch (type) {
    case 'dva':
      return ProphylaxisIndicationType.dva;
    case 'tce':
      return ProphylaxisIndicationType.tce;
    case 'avc':
      return ProphylaxisIndicationType.avc;
    case 'queimado':
      return ProphylaxisIndicationType.burnt;
    case 'jejum_prolongado':
      return ProphylaxisIndicationType.fastingProlonged;
    case 'nao_indicado':
      return ProphylaxisIndicationType.notRecommended;
    case 'terapeutico':
      return ProphylaxisIndicationType.therapeutic;
    case 'vm_mais_72h':
      return ProphylaxisIndicationType.vmMore72h;
    default:
      return null;
  }
}
