import 'dart:convert';

class ExtraDocumentsModel {
  String? id;
  String? file;
  String? observation;
  ExtraDocumentsModel({
    this.id,
    this.file,
    this.observation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'arquivo': file,
      'observacao': observation,
    };
  }

  factory ExtraDocumentsModel.fromMap(Map<String, dynamic> map) {
    return ExtraDocumentsModel(
      id: map['id'],
      file: map['arquivo'],
      observation: map['observacao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExtraDocumentsModel.fromJson(String source) =>
      ExtraDocumentsModel.fromMap(json.decode(source));
}
