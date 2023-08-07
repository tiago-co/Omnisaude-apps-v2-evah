enum AcceptationType {
  total,
  partial,
  declined,
}

extension AcceptationExtension on AcceptationType {
  String get label {
    switch (this) {
      case AcceptationType.total:
        return 'Total';
      case AcceptationType.partial:
        return 'Parcial';
      case AcceptationType.declined:
        return 'Recusado';
    }
  }

  String get toJson {
    switch (this) {
      case AcceptationType.total:
        return 'total';
      case AcceptationType.partial:
        return 'parcial';
      case AcceptationType.declined:
        return 'recusado';
    }
  }
}

AcceptationType? acceptationFromJson(String? type) {
  switch (type) {
    case 'total':
      return AcceptationType.total;
    case 'parcial':
      return AcceptationType.partial;
    case 'recusado':
      return AcceptationType.declined;
    default:
      return null;
  }
}
