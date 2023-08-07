enum RespiratoryTypes {
  eupneicWithoutChanges,
  audibleRattle,
  ineffectivecough,
  tracheostomy,
}

extension RespiratoryTypesExtension on RespiratoryTypes {
  String get label {
    switch (this) {
      case RespiratoryTypes.eupneicWithoutChanges:
        return 'Eupneico sem alterações';
      case RespiratoryTypes.audibleRattle:
        return 'Estertoracao audivel';
      case RespiratoryTypes.ineffectivecough:
        return 'Tosse ineficaz';
      case RespiratoryTypes.tracheostomy:
        return 'Traqueostomia';
    }
  }

  String get toJson {
    switch (this) {
      case RespiratoryTypes.eupneicWithoutChanges:
        return 'eupineico_sem_alteracoes';
      case RespiratoryTypes.audibleRattle:
        return 'estertoracao_audivel';
      case RespiratoryTypes.ineffectivecough:
        return 'tosse_ineficaz';
      case RespiratoryTypes.tracheostomy:
        return 'traqueostomia';
    }
  }
}

RespiratoryTypes? respiratoryTypeFromJson(String? type) {
  switch (type) {
    case 'eupineico_sem_alteracoes':
      return RespiratoryTypes.eupneicWithoutChanges;
    case 'estertoracao_audivel':
      return RespiratoryTypes.audibleRattle;
    case 'tosse_ineficaz':
      return RespiratoryTypes.ineffectivecough;
    case 'traqueostomia':
      return RespiratoryTypes.tracheostomy;
    default:
      return null;
  }
}
