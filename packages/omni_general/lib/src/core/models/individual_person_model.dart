import 'package:omni_general/src/core/enums/blood_type_enum.dart';
import 'package:omni_general/src/core/enums/ethnicity_type_enum.dart';
import 'package:omni_general/src/core/enums/genre_type_enum.dart';
import 'package:omni_general/src/core/enums/marital_status_enum.dart';

import 'package:omni_general/src/core/models/address_model.dart';
import 'package:omni_general/src/core/models/user_model.dart';

class IndividualPersonModel {
  UserModel? user;
  String? name;
  String? cpf;
  String? fatherName;
  String? motherName;
  String? birth;
  double? height;
  double? weight;
  MaritalStatus? maritalStatus;
  String? phone;
  BloodType? bloodType;
  EthnicityType? ethnicity;
  GenreType? genre;
  String? image;
  AddressModel? address;

  IndividualPersonModel({
    this.user,
    this.name,
    this.cpf,
    this.fatherName,
    this.motherName,
    this.birth,
    this.height,
    this.weight,
    this.maritalStatus,
    this.phone,
    this.bloodType,
    this.ethnicity,
    this.genre,
    this.image,
    this.address,
  });

  IndividualPersonModel.fromJson(Map<String, dynamic> json) {
    if (json['usuario'] != null) {
      user = UserModel.fromJson(json['usuario']);
    } else {
      user = null;
    }
    name = json['nome'];
    cpf = json['cpf'];
    motherName = json['nome_mae'];
    fatherName = json['nome_pai'];
    birth = json['dt_nascimento'];
    height = json['altura'];
    weight = json['peso'];
    phone = json['telefone'];
    bloodType = bloodTypeFromJson(json['tipo_sanguineo']);
    ethnicity = ethnicityTypeFromJson(json['cor']);
    genre = genreTypeFromJson(json['sexo']);
    maritalStatus = maritalStatusFromJson(json['estado_civil']);
    image = json['imagem'];
    if (json['endereco'] != null) {
      address = AddressModel.fromJson(json['endereco']);
    } else {
      address = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usuario'] = user?.toJson();
    data['nome'] = name;
    data['cpf'] = cpf;
    data['nome_mae'] = motherName;
    data['nome_pai'] = fatherName;
    data['dt_nascimento'] = birth;
    data['altura'] = height;
    data['peso'] = weight;
    data['estado_civil'] = maritalStatus;
    data['telefone'] = phone;
    data['tipo_sanguineo'] = bloodType?.toJson;
    data['cor'] = ethnicity?.toJson;
    data['sexo'] = genre?.toJson;
    data['estado_civil'] = maritalStatus?.toJson;
    data['imagem'] = image;
    data['endereco'] = address?.toJson();
    return data;
  }
}
