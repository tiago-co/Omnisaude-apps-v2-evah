enum FileType { custom, image, pdf, any }

extension FileTypeExtension on FileType {
  String? get toJson {
    switch (this) {
      case FileType.custom:
        return 'custom';
      case FileType.image:
        return 'image';
      case FileType.pdf:
        return 'pdf';
      case FileType.any:
        return 'any';
      default:
        return null;
    }
  }
}

FileType? fileTypeFromJson(String type) {
  switch (type) {
    case 'custom':
      return FileType.custom;
    case 'image':
      return FileType.image;
    case 'pdf':
      return FileType.pdf;
    case 'any':
      return FileType.any;
    default:
      return null;
  }
}
