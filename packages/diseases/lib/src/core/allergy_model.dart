import 'dart:convert';

class AllergyModel {
  String? id;
  String? name;
  String? observation;
  AllergyModel({
    this.id,
    this.name,
    this.observation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'observacao': observation,
    };
  }

  factory AllergyModel.fromMap(Map<String, dynamic> map) {
    return AllergyModel(
      id: map['id'] ?? '',
      name: map['nome'] ?? '',
      observation: map['observacao'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AllergyModel.fromJson(String source) =>
      AllergyModel.fromMap(json.decode(source));
}
