class BotModel {
  String? id;
  String? avatar;
  String? name;
  String? organization;

  BotModel({this.id, this.avatar, this.name, this.organization});

  BotModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    name = json['name'];
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['name'] = name;
    data['organization'] = organization;
    return data;
  }
}
