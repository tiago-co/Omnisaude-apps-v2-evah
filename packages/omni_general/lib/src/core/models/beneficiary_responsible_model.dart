import 'dart:convert';

import 'package:omni_general/src/core/enums/relationship_type_enum.dart';

class BeneficiaryResponsibleModel {
  String? name;
  String? birth;
  String? cpf;
  late List<String> phone;
  late List<String> email;
  RelationshipType? type;

  BeneficiaryResponsibleModel({
    this.name,
    this.birth,
    this.cpf,
    this.phone = const [],
    this.email = const [],
    this.type,
  });

  // BeneficiaryResponsibleModel.fromJson(Map<String, dynamic> json) {
  //   name = json['nome'];
  //   birth = json['data_nascimento'];
  //   cpf = json['cpf'];
  //   phone = json['telefones'].cast<String>();
  //   email = json['emails'].cast<String>();
  //   type = relationshipTypeFromJson(json['tipo_relacao']);
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['nome'] = name;
  //   data['data_nascimento'] = birth;
  //   data['cpf'] = cpf;
  //   data['telefones'] = phone;
  //   data['emails'] = email;
  //   data['tipo_relacao'] = type?.toJson;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'nome': name});
    }
    if (birth != null) {
      result.addAll({'data_nascimento': birth});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    result.addAll({'telefones': phone});
    result.addAll({'emails': email});
    if (type != null) {
      result.addAll({'tipo_relacao': type?.toJson});
    }

    return result;
  }

  factory BeneficiaryResponsibleModel.fromMap(Map<String, dynamic> map) {
    return BeneficiaryResponsibleModel(
      name: map['nome'],
      birth: map['data_nascimento'],
      cpf: map['cpf'],
      phone: List<String>.from(map['telefones']),
      email: List<String>.from(map['emails']),
      type: map['tipo_relacao'] != null
          ? relationshipTypeFromJson(map['tipo_relacao'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficiaryResponsibleModel.fromJson(String source) =>
      BeneficiaryResponsibleModel.fromMap(json.decode(source));
}
