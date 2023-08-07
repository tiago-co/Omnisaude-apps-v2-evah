enum PainPresenceType {
  painful,
  painless,
  ascitic,
}

extension PainPresenceTypeExtension on PainPresenceType {
  String get label {
    switch (this) {
      case PainPresenceType.painful:
        return 'Doloroso';
      case PainPresenceType.painless:
        return 'Indolor';
      case PainPresenceType.ascitic:
        return 'Ascitico';
    }
  }

  String get toJson {
    switch (this) {
      case PainPresenceType.painful:
        return 'doloroso';
      case PainPresenceType.painless:
        return 'indolor';
      case PainPresenceType.ascitic:
        return 'ascitico';
    }
  }
}

PainPresenceType? painPresenceTypeFromJson(String? type) {
  switch (type) {
    case 'doloroso':
      return PainPresenceType.painful;
    case 'indolor':
      return PainPresenceType.painless;
    case 'ascitico':
      return PainPresenceType.ascitic;
    default:
      return null;
  }
}
