import 'package:omni_general/src/core/enums/blood_type_enum.dart';
import 'package:omni_general/src/core/enums/ethnicity_type_enum.dart';
import 'package:omni_general/src/core/enums/genre_type_enum.dart';
import 'package:omni_general/src/core/enums/marital_status_enum.dart';

import 'package:omni_general/src/core/models/address_model.dart';
import 'package:omni_general/src/core/models/user_model.dart';

class IndividualPersonModel {
  UserModel? user;
  int? id;
  String? name;
  String? cpf;
  String? email;
  String? fatherName;
  String? motherName;
  String? birth;
  int? height;
  double? weight;
  MaritalStatus? maritalStatus;
  String? phone;
  String? emergencyContact;
  BloodType? bloodType;
  EthnicityType? ethnicity;
  GenreType? genre;
  String? image;
  bool? isCompleted;
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
    this.emergencyContact,
    this.bloodType,
    this.ethnicity,
    this.genre,
    this.image,
    this.address,
  });

  IndividualPersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cpf = json['cpf'];
    email = json['email'];
    birth = json['birth_date'];
    height = json['height'] is String ? double.parse(json['height']) : json['height'];
    weight = json['weight'] is int ? (json['weight'] as int).toDouble() : json['weight'];
    phone = json['phone'];
    emergencyContact = json['emergency_phone'];
    maritalStatus = maritalStatusFromJson(json['marital_status']);
    image = json['image'];
    isCompleted = json['is_completed'];
    if (json['address'] != null) {
      address = AddressModel.fromJson(json['address']);
    } else {
      address = null;
    }
  }
  IndividualPersonModel.oldFromJson(Map<String, dynamic> json) {
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
    height = json['altura'] is double ? (json['altura'] as double).toInt() : json['altura'];
    weight = json['peso'];
    phone = json['telefone'];
    bloodType = bloodTypeFromJson(json['tipo_sanguineo']);
    ethnicity = ethnicityTypeFromJson(json['cor']);
    genre = genreTypeFromJson(json['sexo']);
    maritalStatus = maritalStatusFromJson(json['estado_civil']);
    image = json['imagem'];
    if (json['endereco'] != null) {
      address = AddressModel.oldFromJson(json['endereco']);
    } else {
      address = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cpf'] = cpf;
    data['email'] = email;
    data['birth_date'] = birth;
    data['height'] = height;
    data['weight'] = weight;
    data['marital_status'] = maritalStatus?.toJson;
    data['phone'] = phone;
    data['emergency_phone'] = emergencyContact;
    data['image'] = '';
    data['address'] = address?.toJson();
    return data;
  }

  Map<String, dynamic> oldToJson() {
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
    data['endereco'] = address?.OldToJson();
    return data;
  }
}
