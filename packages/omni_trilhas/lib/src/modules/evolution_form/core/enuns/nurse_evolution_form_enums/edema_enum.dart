enum EdemaType {
  noEdema,
  edemaMMII1,
  edemaMMII2,
  edemaMMII3,
  anasarca,
}

extension EdemaTypeExtension on EdemaType {
  String get label {
    switch (this) {
      case EdemaType.noEdema:
        return 'Sem Edema';
      case EdemaType.edemaMMII1:
        return 'Edema MMII1';
      case EdemaType.edemaMMII2:
        return 'Edema MMII2';
      case EdemaType.edemaMMII3:
        return 'Edema MMII3';
      case EdemaType.anasarca:
        return 'Anasarca';
    }
  }

  String get toJson {
    switch (this) {
      case EdemaType.noEdema:
        return 'sem_edema';
      case EdemaType.edemaMMII1:
        return 'edema1';
      case EdemaType.edemaMMII2:
        return 'edema2';
      case EdemaType.edemaMMII3:
        return 'edema3';
      case EdemaType.anasarca:
        return 'anasarca';
    }
  }
}

EdemaType? edemaTypeFromJson(String? type) {
  switch (type) {
    case 'sem_edema':
      return EdemaType.noEdema;
    case 'edema1':
      return EdemaType.edemaMMII1;
    case 'edema2':
      return EdemaType.edemaMMII2;
    case 'edema3':
      return EdemaType.edemaMMII3;
    case 'anasarca':
      return EdemaType.anasarca;
    default:
      return null;
  }
}
