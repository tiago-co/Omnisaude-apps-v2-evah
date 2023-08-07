enum ChestDrainType {
  left,
  right,
  bilateral,
  away,
}

extension ChestDrainTypeExtension on ChestDrainType {
  String get label {
    switch (this) {
      case ChestDrainType.left:
        return 'Esquerdo';
      case ChestDrainType.right:
        return 'Direito';
      case ChestDrainType.bilateral:
        return 'Bilateral';
      case ChestDrainType.away:
        return 'Ausente';
    }
  }

  String get toJson {
    switch (this) {
      case ChestDrainType.left:
        return 'esquerdo';
      case ChestDrainType.right:
        return 'direito';
      case ChestDrainType.bilateral:
        return 'bilateral';
      case ChestDrainType.away:
        return 'ausente';
    }
  }
}

ChestDrainType? chestDrainTypeFromJson(String? type) {
  switch (type) {
    case 'esquerdo':
      return ChestDrainType.left;
    case 'direito':
      return ChestDrainType.right;
    case 'bilateral':
      return ChestDrainType.bilateral;
    case 'ausente':
      return ChestDrainType.away;
    default:
      return null;
  }
}
