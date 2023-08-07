class AdministratorUserModel {
  int? id;
  String? authToken;
  String? nodeToken;
  String? email;
  String? role;

  AdministratorUserModel({
    this.id,
    this.authToken,
    this.nodeToken,
    this.email,
    this.role,
  });

  AdministratorUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authToken = json['auth_token'];
    nodeToken = json['node_token'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['auth_token'] = authToken;
    data['node_token'] = nodeToken;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
