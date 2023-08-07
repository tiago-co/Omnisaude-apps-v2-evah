enum CardiologicTypes {
  normocardiumWithoutChanges,
  irregularHeartRhythm,
  pacemaker,
  audibleMurmur,
}

extension CardiologicTypesExtension on CardiologicTypes {
  String get label {
    switch (this) {
      case CardiologicTypes.normocardiumWithoutChanges:
        return 'Normocárdio sem alterações';
      case CardiologicTypes.irregularHeartRhythm:
        return 'Ritmo cardíaco irregular';
      case CardiologicTypes.pacemaker:
        return 'Marcapasso';
      case CardiologicTypes.audibleMurmur:
        return 'Sopro audivel';
    }
  }

  String get toJson {
    switch (this) {
      case CardiologicTypes.normocardiumWithoutChanges:
        return 'normocardio_sem_alteracoes';
      case CardiologicTypes.irregularHeartRhythm:
        return 'ritmo_cardiaco_irregular';
      case CardiologicTypes.pacemaker:
        return 'marcapasso';
      case CardiologicTypes.audibleMurmur:
        return 'sopro_audivel';
    }
  }
}

CardiologicTypes? cardiologicTypesFromJson(String? type) {
  switch (type) {
    case 'normocardio_sem_alteracoes':
      return CardiologicTypes.normocardiumWithoutChanges;
    case 'ritmo_cardiaco_irregular':
      return CardiologicTypes.irregularHeartRhythm;
    case 'marcapasso':
      return CardiologicTypes.pacemaker;
    case 'sopro_audivel':
      return CardiologicTypes.audibleMurmur;
    default:
      return null;
  }
}
