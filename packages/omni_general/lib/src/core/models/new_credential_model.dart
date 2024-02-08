class NewCredentialModel {
  String? cpfOrEmail;
  String? password;

  NewCredentialModel({this.cpfOrEmail, this.password});

  NewCredentialModel.fromJson(Map<String, dynamic> json) {
    cpfOrEmail = json['cpf_or_email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpf_or_email'] = cpfOrEmail;
    data['password'] = password;
    return data;
  }
}
