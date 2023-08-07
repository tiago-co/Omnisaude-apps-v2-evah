enum PupilsType {
  isochoric,
  pupils,
  miosis,
  mydriasis,
}

extension PupilsTypeExtension on PupilsType {
  String get label {
    switch (this) {
      case PupilsType.isochoric:
        return 'Isocóricas Fotoregente';
      case PupilsType.pupils:
        return 'Pupilas';
      case PupilsType.miosis:
        return 'Miose';
      case PupilsType.mydriasis:
        return 'Midríase';
    }
  }

  String get toJson {
    switch (this) {
      case PupilsType.isochoric:
        return 'isocoricas';
      case PupilsType.pupils:
        return 'pupilas';
      case PupilsType.miosis:
        return 'miose';
      case PupilsType.mydriasis:
        return 'midriase';
    }
  }
}

PupilsType? pupilsTypeFromJson(String? type) {
  switch (type) {
    case 'isocoricas':
      return PupilsType.isochoric;
    case 'pupilas':
      return PupilsType.pupils;
    case 'miose':
      return PupilsType.miosis;
    case 'midriase':
      return PupilsType.mydriasis;
    default:
      return null;
  }
}
