enum EvolutionFormType {
  doctor,
  nursing,
  physiotherapist,
  nutritionist,
  psychologist,
  technicalNursing,
  therapist,
}

extension EvolutionFormTypeExtension on EvolutionFormType {
  String get label {
    switch (this) {
      case EvolutionFormType.doctor:
        return 'Médica';
      case EvolutionFormType.nursing:
        return 'Enfermagem';
      case EvolutionFormType.physiotherapist:
        return 'Fisioterapia';
      case EvolutionFormType.nutritionist:
        return 'Nutricionista';
      case EvolutionFormType.psychologist:
        return 'Psicologo';
      case EvolutionFormType.technicalNursing:
        return 'Técnico de Enfermagem';
      case EvolutionFormType.therapist:
        return 'Terapeuta';
    }
  }

  String get url {
    switch (this) {
      case EvolutionFormType.doctor:
        return '/mobile/omni/formulario-medico/';
      case EvolutionFormType.nursing:
        return '/mobile/omni/formulario-enfermagem/';
      case EvolutionFormType.physiotherapist:
        return '/mobile/omni/formulario-fisioterapia/';
      case EvolutionFormType.nutritionist:
        return '/mobile/omni/formulario-nutricionista/';
      case EvolutionFormType.psychologist:
        return '/mobile/omni/formulario-psicologo/';
      case EvolutionFormType.technicalNursing:
        return '/mobile/omni/formulario-tecnico-enfermagem/';
      case EvolutionFormType.therapist:
        return '/mobile/omni/formulario-terapeuta/';
    }
  }

  String get toJson {
    switch (this) {
      case EvolutionFormType.doctor:
        return 'medico';
      case EvolutionFormType.nursing:
        return 'enfermagem';
      case EvolutionFormType.physiotherapist:
        return 'fisioterapeuta';
      case EvolutionFormType.nutritionist:
        return 'nutricionista';
      case EvolutionFormType.psychologist:
        return 'psicologo';
      case EvolutionFormType.technicalNursing:
        return 'tecnico_enfermagem';
      case EvolutionFormType.therapist:
        return 'terapeuta';
    }
  }
}

EvolutionFormType? evolutionFormTypeFromJson(String? type) {
  switch (type) {
    case 'medico':
      return EvolutionFormType.doctor;
    case 'enfermagem':
      return EvolutionFormType.nursing;
    case 'fisioterapeuta':
      return EvolutionFormType.physiotherapist;
    case 'nutricionista':
      return EvolutionFormType.nutritionist;
    case 'psicologo':
      return EvolutionFormType.psychologist;
    case 'tecnico_enfermagem':
      return EvolutionFormType.technicalNursing;
    case 'terapeuta':
      return EvolutionFormType.therapist;
    default:
      return null;
  }
}
