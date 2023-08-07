import 'dart:convert';

class DiseasesModel {
  int? id;
  String? name;
  String? observation;
  DiseasesModel({
    this.id,
    this.name,
    this.observation,
  });

  Map<String, dynamic> toMap() {
    return {
      'doenca': id,
      'nome': name,
      'observacao': observation,
    };
  }

  factory DiseasesModel.fromMap(Map<String, dynamic> map) {
    return DiseasesModel(
      id: map['doenca']['id']?.toInt(),
      name: map['doenca']['nome'] ?? '',
      observation: map['observacao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseasesModel.fromJson(String source) =>
      DiseasesModel.fromMap(json.decode(source));
}
