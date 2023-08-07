class AdministratorCredentialsModel {
  String? email;
  String? password;

  AdministratorCredentialsModel({
    this.email,
    this.password,
  });

  AdministratorCredentialsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
