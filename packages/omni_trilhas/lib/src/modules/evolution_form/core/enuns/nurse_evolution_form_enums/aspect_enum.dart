enum AspectType {
  mucoid,
  purulent,
  mucupurulent,
  bloody,
}

extension AspectTypeExtension on AspectType {
  String get label {
    switch (this) {
      case AspectType.mucoid:
        return 'Mucoide';
      case AspectType.purulent:
        return 'Purulenta';
      case AspectType.mucupurulent:
        return 'Mucupurulenta';
      case AspectType.bloody:
        return 'Sanguinolenta';
    }
  }

  String get toJson {
    switch (this) {
      case AspectType.mucoid:
        return 'mucoide';
      case AspectType.purulent:
        return 'purulenta';
      case AspectType.mucupurulent:
        return 'mucupurulenta';
      case AspectType.bloody:
        return 'sanguinolenta';
    }
  }
}

AspectType? aspectTypeFromJson(String? type) {
  switch (type) {
    case 'mucoide':
      return AspectType.mucoid;
    case 'purulenta':
      return AspectType.purulent;
    case 'mucupurulenta':
      return AspectType.mucupurulent;
    case 'sanguinolenta':
      return AspectType.bloody;
    default:
      return null;
  }
}
