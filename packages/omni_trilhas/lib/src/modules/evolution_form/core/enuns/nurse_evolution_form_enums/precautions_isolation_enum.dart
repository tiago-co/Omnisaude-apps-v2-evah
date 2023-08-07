enum PrecautionIsolationType {
  contact,
  droplets,
  aerosols,
  pattern,
  surveillance,
}

extension PrecautionIsolationTypeExtension on PrecautionIsolationType {
  String get label {
    switch (this) {
      case PrecautionIsolationType.contact:
        return 'Precaução Contato';
      case PrecautionIsolationType.droplets:
        return 'Precaução para Gotículas';
      case PrecautionIsolationType.aerosols:
        return 'Precaução para Aerossóis';
      case PrecautionIsolationType.pattern:
        return 'Precaução Padrão';
      case PrecautionIsolationType.surveillance:
        return 'Precaução de Vigilância';
    }
  }

  String get toJson {
    switch (this) {
      case PrecautionIsolationType.contact:
        return 'contato';
      case PrecautionIsolationType.droplets:
        return 'goticulas';
      case PrecautionIsolationType.aerosols:
        return 'aerossois';
      case PrecautionIsolationType.pattern:
        return 'padrao';
      case PrecautionIsolationType.surveillance:
        return 'vigilancia';
    }
  }
}

PrecautionIsolationType? precautionIsolationTypeFromJson(String? type) {
  switch (type) {
    case 'contato':
      return PrecautionIsolationType.contact;
    case 'goticulas':
      return PrecautionIsolationType.droplets;
    case 'aerossois':
      return PrecautionIsolationType.aerosols;
    case 'padrao':
      return PrecautionIsolationType.pattern;
    case 'vigilancia':
      return PrecautionIsolationType.surveillance;
    default:
      return null;
  }
}
