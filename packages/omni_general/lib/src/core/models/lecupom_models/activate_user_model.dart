class ActivateUserModel {
  int? id;
  String? name;
  String? email;
  String? cpf;
  String? phone;
  bool? active;
  String? createdAt;
  String? updatedAt;
  String? password;
  List<String>? userTags;

  ActivateUserModel({
    this.id,
    this.active,
    this.cpf,
    this.email,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.userTags,
    this.password,
  });

  ActivateUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    phone = json['phone'];
    active = json['active'];
    if (json['user_tags'] != null) {
      userTags = List.empty(growable: true);
      json['user_tags'].forEach((element) {
        userTags?.add(element);
      });
    }
    password = json['password'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['cpf'] = cpf;
    data['phone'] = phone;
    data['activated_at'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_tags'] = userTags;
    data['password'] = password;
    return data;
  }
}
