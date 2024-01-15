class NewCredentialModel {
  String? cpf;
  String? email;
  String? password;
  String? username;

  NewCredentialModel({this.cpf, this.email, this.password});

  NewCredentialModel.fromJson(Map<String, dynamic> json) {
    // cpf = json['cpf'];
    // email = json['email'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (username != null && username!.contains('@')) {
      data['email'] = username;
    } else {
      data['cpf'] = username;
    }
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
