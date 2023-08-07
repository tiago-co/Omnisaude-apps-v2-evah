class AnswerDynamicFormModel {
  String? id;
  late List<FieldModel> fields;

  AnswerDynamicFormModel({this.id, this.fields = const []});

  AnswerDynamicFormModel.fromJson(Map<String, dynamic> json) {
    id = json['referencia_id'];
    if (json['campos'] != null) {
      fields = List<FieldModel>.empty(growable: true);
      json['campos'].forEach((v) {
        fields.add(FieldModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referencia_id'] = id;
    data['campos'] = fields.map((v) => v.toJson()).toList();
    return data;
  }
}

class FieldModel {
  String? id;
  late bool isRequired;
   String? value;

  FieldModel({this.id, this.value, this.isRequired = false});

  FieldModel.fromJson(Map<String, dynamic> json) {
    id = json['referencia_id'];
    isRequired = json['obrigatorio'] ?? false;
    value = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referencia_id'] = id;
    data['obrigatorio'] = isRequired;
    data['valor'] = value;
    return data;
  }
}
