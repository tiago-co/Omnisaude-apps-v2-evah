enum MotorDeficitType {
  noDeficit,
  withDeficit,
  impairedAssessment,
}

extension MotorDeficitTypeExtension on MotorDeficitType {
  String get label {
    switch (this) {
      case MotorDeficitType.noDeficit:
        return 'Sem Déficit Motor';
      case MotorDeficitType.withDeficit:
        return 'Com Déficit Motor';
      case MotorDeficitType.impairedAssessment:
        return 'Avaliação prejudicada pelo nivel de consciência';
    }
  }

  String get toJson {
    switch (this) {
      case MotorDeficitType.noDeficit:
        return 'sem_deficit';
      case MotorDeficitType.withDeficit:
        return 'com_deficit';
      case MotorDeficitType.impairedAssessment:
        return 'avaliacao_prejudicada';
    }
  }
}

MotorDeficitType? motorDeficitTypeFromJson(String? type) {
  switch (type) {
    case 'sem_deficit':
      return MotorDeficitType.noDeficit;
    case 'com_deficit':
      return MotorDeficitType.withDeficit;
    case 'avaliacao_prejudicada':
      return MotorDeficitType.impairedAssessment;
    default:
      return null;
  }
}
