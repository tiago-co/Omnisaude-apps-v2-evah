enum DiagnosticTypes {
  coronaryArteryDisease,
  chronicObstructivePulmonaryDisease,
  amyotrophicLateralSclerosis,
  chronicAtrialFibrillation,
  type1DiabetesMellitus,
  type2DiabetesMellitus,
  hepaticalCirrhosis,
  postoperativeAbdominalSurgery,
  postStrokeEncephalopathy,
  ischemicAnoxicEncephalopathy,
  senileDementia,
  alzheimerDisease,
  parkinsonDisease,
  prolongedMechanicalVentilation,
  chronicMalnutrition,
  criticallyIllPolyneuropathy,
}

extension DiagnosticTypesExtension on DiagnosticTypes {
  String get label {
    switch (this) {
      case DiagnosticTypes.coronaryArteryDisease:
        return 'Doença arterial corononariana';
      case DiagnosticTypes.chronicObstructivePulmonaryDisease:
        return 'Doença pulmonar obstrutiva crônica';
      case DiagnosticTypes.amyotrophicLateralSclerosis:
        return 'Esclerose Lateral Amiotrófica';
      case DiagnosticTypes.chronicAtrialFibrillation:
        return 'Fibrilação atrial crônica';
      case DiagnosticTypes.type1DiabetesMellitus:
        return 'Diabetes Mellitus tipo 1';
      case DiagnosticTypes.type2DiabetesMellitus:
        return 'Diabettes Mellitus tipo 2';
      case DiagnosticTypes.hepaticalCirrhosis:
        return 'Cirrose hepática';
      case DiagnosticTypes.postoperativeAbdominalSurgery:
        return 'Pós-operatório de cirurgia abdominal';
      case DiagnosticTypes.postStrokeEncephalopathy:
        return 'Encefalopatia pós AVC';
      case DiagnosticTypes.ischemicAnoxicEncephalopathy:
        return 'Encefalopatia anóxica isquêmica';
      case DiagnosticTypes.senileDementia:
        return 'Demência senil';
      case DiagnosticTypes.alzheimerDisease:
        return 'Doença de Alzheimer';
      case DiagnosticTypes.parkinsonDisease:
        return 'Doença de Parkinson';
      case DiagnosticTypes.prolongedMechanicalVentilation:
        return 'Ventilação Mecânica prolongada';
      case DiagnosticTypes.chronicMalnutrition:
        return 'Desnutrição crônica';
      case DiagnosticTypes.criticallyIllPolyneuropathy:
        return 'Polineuropatia do doente crítico';
    }
  }

  String get toJson {
    switch (this) {
      case DiagnosticTypes.coronaryArteryDisease:
        return 'doenca_arterial_corononariana';
      case DiagnosticTypes.chronicObstructivePulmonaryDisease:
        return 'doenca_pulmonar_obstrutiva_cronica';
      case DiagnosticTypes.amyotrophicLateralSclerosis:
        return 'esclerose_lateral_amiotrofica';
      case DiagnosticTypes.chronicAtrialFibrillation:
        return 'fibrilacao_atrial_cronica';
      case DiagnosticTypes.type1DiabetesMellitus:
        return 'diabetes_mellitus_tipo1';
      case DiagnosticTypes.type2DiabetesMellitus:
        return 'diabettes_mellitus_tipo2';
      case DiagnosticTypes.hepaticalCirrhosis:
        return 'cirrose_hepatica';
      case DiagnosticTypes.postoperativeAbdominalSurgery:
        return 'pos_operatorio_de_cirurgia';
      case DiagnosticTypes.postStrokeEncephalopathy:
        return 'encefalopatia_pos_avc';
      case DiagnosticTypes.ischemicAnoxicEncephalopathy:
        return 'encefalopatia_anoxica_isquemica';
      case DiagnosticTypes.senileDementia:
        return 'demencia_senil';
      case DiagnosticTypes.alzheimerDisease:
        return 'doença_de_alzheimer';
      case DiagnosticTypes.parkinsonDisease:
        return 'doenca_de_parkinson';
      case DiagnosticTypes.prolongedMechanicalVentilation:
        return 'ventilacao_mecanica_prolongada';
      case DiagnosticTypes.chronicMalnutrition:
        return 'desnutricao_cronica';
      case DiagnosticTypes.criticallyIllPolyneuropathy:
        return 'polineuropatia_do_doente_critico';
    }
  }
}

DiagnosticTypes? diagnosticTypesFromJson(String? type) {
  switch (type) {
    case 'doenca_arterial_corononariana':
      return DiagnosticTypes.coronaryArteryDisease;
    case 'doenca_pulmonar_obstrutiva_cronica':
      return DiagnosticTypes.chronicObstructivePulmonaryDisease;
    case 'esclerose_lateral_amiotrofica':
      return DiagnosticTypes.amyotrophicLateralSclerosis;
    case 'fibrilacao_atrial_cronica':
      return DiagnosticTypes.chronicAtrialFibrillation;
    case 'diabetes_mellitus_tipo1':
      return DiagnosticTypes.type1DiabetesMellitus;
    case 'diabettes_mellitus_tipo2':
      return DiagnosticTypes.type2DiabetesMellitus;
    case 'cirrose_hepatica':
      return DiagnosticTypes.hepaticalCirrhosis;
    case 'pos_operatorio_de_cirurgia':
      return DiagnosticTypes.postoperativeAbdominalSurgery;
    case 'encefalopatia_pos_avc':
      return DiagnosticTypes.postStrokeEncephalopathy;
    case 'encefalopatia_anoxica_isquemica':
      return DiagnosticTypes.ischemicAnoxicEncephalopathy;
    case 'demencia_senil':
      return DiagnosticTypes.senileDementia;
    case 'doença_de_alzheimer':
      return DiagnosticTypes.alzheimerDisease;
    case 'doenca_de_parkinson':
      return DiagnosticTypes.parkinsonDisease;
    case 'ventilacao_mecanica_prolongada':
      return DiagnosticTypes.prolongedMechanicalVentilation;
    case 'desnutricao_cronica':
      return DiagnosticTypes.chronicMalnutrition;
    case 'polineuropatia_do_doente_critico':
      return DiagnosticTypes.criticallyIllPolyneuropathy;
    default:
      return null;
  }
}
