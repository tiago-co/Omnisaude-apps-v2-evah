enum VentilationTypes {
  invasiveMechanics,
  spontaneousAmbientAir,
  spontaneousO2Support,
}

extension VentilationTypesExtension on VentilationTypes {
  String get label {
    switch (this) {
      case VentilationTypes.invasiveMechanics:
        return 'Mecânica invasiva';
      case VentilationTypes.spontaneousAmbientAir:
        return 'Espontânea em ar ambiente';
      case VentilationTypes.spontaneousO2Support:
        return 'Espontânea com suporte O2';
    }
  }

  String get toJson {
    switch (this) {
      case VentilationTypes.invasiveMechanics:
        return 'ventilacao_mecanica_invasiva';
      case VentilationTypes.spontaneousAmbientAir:
        return 'ventilacao_ar_ambiente';
      case VentilationTypes.spontaneousO2Support:
        return 'ventilacao_suporte_o2"';
    }
  }
}

VentilationTypes? ventilationTypesFromJson(String? type) {
  switch (type) {
    case 'ventilacao_mecanica_invasiva':
      return VentilationTypes.invasiveMechanics;
    case 'ventilacao_ar_ambiente':
      return VentilationTypes.spontaneousAmbientAir;
    case 'ventilacao_suporte_o2':
      return VentilationTypes.spontaneousO2Support;
    default:
      return null;
  }
}
