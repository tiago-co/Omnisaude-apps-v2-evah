enum AspectSecretionType {
  thick,
  purulent,
  serosa,
  fluidHyaline,
  hematic,
  feelings,
}

extension AspectSecretionTypeExtension on AspectSecretionType {
  String get label {
    switch (this) {
      case AspectSecretionType.thick:
        return 'Espessa';
      case AspectSecretionType.purulent:
        return 'Purulenta';
      case AspectSecretionType.serosa:
        return 'Serosa';
      case AspectSecretionType.fluidHyaline:
        return 'Fluída/Hialina';
      case AspectSecretionType.hematic:
        return 'Hemática';
      case AspectSecretionType.feelings:
        return 'Sendimentos';
    }
  }

  String get toJson {
    switch (this) {
      case AspectSecretionType.thick:
        return 'espessa';
      case AspectSecretionType.purulent:
        return 'purulenta';
      case AspectSecretionType.serosa:
        return 'serosa';
      case AspectSecretionType.fluidHyaline:
        return 'fluida_hialina';
      case AspectSecretionType.hematic:
        return 'hematica';
      case AspectSecretionType.feelings:
        return 'sendimentos';
    }
  }
}

AspectSecretionType? aspectSecretionTypeFromJson(String? type) {
  switch (type) {
    case 'espessa':
      return AspectSecretionType.thick;
    case 'purulenta':
      return AspectSecretionType.purulent;
    case 'serosa':
      return AspectSecretionType.serosa;
    case 'fluida_hialina':
      return AspectSecretionType.fluidHyaline;
    case 'hematica':
      return AspectSecretionType.hematic;
    case 'sendimentos':
      return AspectSecretionType.feelings;
    default:
      return null;
  }
}
