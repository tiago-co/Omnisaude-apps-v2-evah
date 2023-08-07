class MedicalRecordsFieldModel {
  dynamic id;
  String? type;
  String? code;
  String? name;
  String? description;

  MedicalRecordsFieldModel({
    this.id,
    this.type,
    this.code,
    this.name,
    this.description,
  });

  MedicalRecordsFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['tipo'];
    code = json['codigo'];
    name = json['nome'];
    description = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = type;
    data['codigo'] = code;
    data['nome'] = name;
    data['descricao'] = description;
    return data;
  }
}
