enum HeartRhythmType {
  sinusRhythm,
  arrhythmia,
  pacemaker,
  heartMurmur,
}

extension HeartRhythmTypeExtension on HeartRhythmType {
  String get label {
    switch (this) {
      case HeartRhythmType.sinusRhythm:
        return 'Ritmo Sinusal';
      case HeartRhythmType.arrhythmia:
        return 'Arritmia';
      case HeartRhythmType.pacemaker:
        return 'Marcapasso';
      case HeartRhythmType.heartMurmur:
        return 'Sopro Cardíaco"';
    }
  }

  String get toJson {
    switch (this) {
      case HeartRhythmType.sinusRhythm:
        return 'ritmo_sinusal';
      case HeartRhythmType.arrhythmia:
        return 'arritmia';
      case HeartRhythmType.pacemaker:
        return 'marcapasso';
      case HeartRhythmType.heartMurmur:
        return 'sopro_cardiaco';
    }
  }
}

HeartRhythmType? heartRhythmTypeFromJson(String? type) {
  switch (type) {
    case 'ritmo_sinusal':
      return HeartRhythmType.sinusRhythm;
    case 'arritmia':
      return HeartRhythmType.arrhythmia;
    case 'marcapasso':
      return HeartRhythmType.pacemaker;
    case 'sopro_cardiaco':
      return HeartRhythmType.heartMurmur;
    default:
      return null;
  }
}
