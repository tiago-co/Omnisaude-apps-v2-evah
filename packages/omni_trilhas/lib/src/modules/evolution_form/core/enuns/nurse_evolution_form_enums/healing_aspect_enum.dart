enum HealingAspectType {
  cleanDry,
  phlogisticSecretion,
  phlogisticsWithoutSecretion,
  bloodyWithoutPhlogistic,
}

extension HealingAspectTypeExtension on HealingAspectType {
  String get label {
    switch (this) {
      case HealingAspectType.cleanDry:
        return 'Limpa e seca, em sinais flogísticos';
      case HealingAspectType.phlogisticSecretion:
        return 'Presença de sinais flogísticos e secreção';
      case HealingAspectType.phlogisticsWithoutSecretion:
        return 'Presença de sinais flogísticos e sem secreção';
      case HealingAspectType.bloodyWithoutPhlogistic:
        return 'Sanguinolento sem sinais flogísticos';
    }
  }

  String get toJson {
    switch (this) {
      case HealingAspectType.cleanDry:
        return 'limpa_seca';
      case HealingAspectType.phlogisticSecretion:
        return 'flogisticos_secrecao';
      case HealingAspectType.phlogisticsWithoutSecretion:
        return 'flogisticos_sem_secrecao';
      case HealingAspectType.bloodyWithoutPhlogistic:
        return 'sanguinolento_sem_flogísticos';
    }
  }
}

HealingAspectType? healingAspectTypeFromJson(String? type) {
  switch (type) {
    case 'limpa_seca':
      return HealingAspectType.cleanDry;
    case 'flogisticos_secrecao':
      return HealingAspectType.phlogisticSecretion;
    case 'flogisticos_sem_secrecao':
      return HealingAspectType.phlogisticsWithoutSecretion;
    case 'sanguinolento_sem_flogísticos':
      return HealingAspectType.bloodyWithoutPhlogistic;
    default:
      return null;
  }
}
