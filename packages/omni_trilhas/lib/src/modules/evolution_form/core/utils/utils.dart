Map<String, dynamic> buildFieldMap(
    {required String type, required dynamic value}) {
  return {
    'type': type,
    'value': value,
  };
}

String boolToString(bool? value) {
  return value == null
      ? 'Não Informado'
      : value
          ? 'Sim'
          : 'Não';
}
