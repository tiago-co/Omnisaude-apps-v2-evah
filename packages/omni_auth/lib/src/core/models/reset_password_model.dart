import 'dart:convert';

class ResetPasswordModel {
  late String? email;
  late String? cpf;
  String? token;
  late String? password;
  late String? id;
  ResetPasswordModel({
    this.email,
    this.cpf,
    this.token = '',
    this.password,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'cpf': cpf,
      'token': token,
      'nova_senha': password,
      'id': id,
    };
  }

  factory ResetPasswordModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordModel(
      email: map['email'],
      cpf: map['cpf'],
      token: map['token'],
      password: map['nova_senha'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordModel.fromJson(String source) =>
      ResetPasswordModel.fromMap(json.decode(source));
}
