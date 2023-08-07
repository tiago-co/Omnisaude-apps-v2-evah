enum ExamsTypes {
  regularGeneralState,
  skinLesion,
  tec5s,
  worseningClinic,
  centralVenousAccess,
  vomitingInThePeriod,
  malnutrition,
  fever,
  bladderDelayProbe,
  peripheralEdema,
}

extension ExamsTypesExtension on ExamsTypes {
  String get label {
    switch (this) {
      case ExamsTypes.regularGeneralState:
        return 'Regular estado geral';
      case ExamsTypes.skinLesion:
        return 'Lesão de pele';
      case ExamsTypes.tec5s:
        return 'TEC > 5s';
      case ExamsTypes.worseningClinic:
        return 'Piora clínica';
      case ExamsTypes.centralVenousAccess:
        return 'Acesso venoso central';
      case ExamsTypes.vomitingInThePeriod:
        return 'Vomitos no período';
      case ExamsTypes.malnutrition:
        return 'Desnutrição';
      case ExamsTypes.fever:
        return 'Febre';
      case ExamsTypes.bladderDelayProbe:
        return 'Sonda vesical de demora';
      case ExamsTypes.peripheralEdema:
        return 'Edema periférico';
    }
  }

  String get toJson {
    switch (this) {
      case ExamsTypes.regularGeneralState:
        return 'regular_estado_geral';
      case ExamsTypes.skinLesion:
        return 'lesao_de_pele';
      case ExamsTypes.tec5s:
        return 'tec_5s';
      case ExamsTypes.worseningClinic:
        return 'piora_clinica';
      case ExamsTypes.centralVenousAccess:
        return 'acesso_venoso_central';
      case ExamsTypes.vomitingInThePeriod:
        return 'vomitos_no_periodo';
      case ExamsTypes.malnutrition:
        return 'desnutricao';
      case ExamsTypes.fever:
        return 'febre';
      case ExamsTypes.bladderDelayProbe:
        return 'sonda_vesical_de_demora';
      case ExamsTypes.peripheralEdema:
        return 'edema_periferico';
    }
  }
}

ExamsTypes? examsTypesFromJson(String? type) {
  switch (type) {
    case 'regular_estado_geral':
      return ExamsTypes.regularGeneralState;
    case 'lesao_de_pele':
      return ExamsTypes.skinLesion;
    case 'tec_5s':
      return ExamsTypes.tec5s;
    case 'piora_clinica':
      return ExamsTypes.worseningClinic;
    case 'acesso_venoso_central':
      return ExamsTypes.centralVenousAccess;
    case 'vomitos_no_periodo':
      return ExamsTypes.vomitingInThePeriod;
    case 'desnutricao':
      return ExamsTypes.malnutrition;
    case 'febre':
      return ExamsTypes.fever;
    case 'sonda_vesical_de_demora':
      return ExamsTypes.bladderDelayProbe;
    case 'edema_periferico':
      return ExamsTypes.peripheralEdema;
    default:
      return null;
  }
}
