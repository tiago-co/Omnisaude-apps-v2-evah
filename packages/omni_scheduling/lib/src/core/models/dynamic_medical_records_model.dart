class DynamicMedicalRecordsModel {
  late List<DynamicMedicalRecordsFieldModel> fields;

  DynamicMedicalRecordsModel({this.fields = const []});

  DynamicMedicalRecordsModel.fromJson(Map<String, dynamic> json) {
    if (json['campos'] != null) {
      fields = List<DynamicMedicalRecordsFieldModel>.empty(growable: true);
      json['campos'].forEach((v) {
        fields.add(DynamicMedicalRecordsFieldModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['campos'] = fields.map((v) => v.toJson()).toList();
    return data;
  }
}

class DynamicMedicalRecordsFieldModel {
  String? value;
  String? field;
  String? description;

  DynamicMedicalRecordsFieldModel({this.value, this.field, this.description});

  DynamicMedicalRecordsFieldModel.fromJson(Map<String, dynamic> json) {
    value = json['valor'];
    field = json['campo'];
    description = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['valor'] = value;
    data['campo'] = field;
    data['descricao'] = description;
    return data;
  }
}
