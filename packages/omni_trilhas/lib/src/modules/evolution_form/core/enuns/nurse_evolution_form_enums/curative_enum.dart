enum CurativeType {
  transparentFilm,
  conventionalCurative,
}

extension CurativeTypeExtension on CurativeType {
  String get label {
    switch (this) {
      case CurativeType.transparentFilm:
        return 'Filme Transparente';
      case CurativeType.conventionalCurative:
        return 'Curativo Convencional';
    }
  }

  String get toJson {
    switch (this) {
      case CurativeType.transparentFilm:
        return 'filme_transparente';
      case CurativeType.conventionalCurative:
        return 'curativo_convencional';
    }
  }
}

CurativeType? curativeTypeFromJson(String? type) {
  switch (type) {
    case 'filme_transparente':
      return CurativeType.transparentFilm;
    case 'curativo_convencional':
      return CurativeType.conventionalCurative;
    default:
      return null;
  }
}
