class UserModel {
  String? name;
  String? avatar;
  String? entered;
  String? peer;
  String? session;

  UserModel({this.name, this.avatar, this.entered, this.peer, this.session});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    entered = json['entered'];
    peer = json['peer'];
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['entered'] = entered;
    data['peer'] = peer;
    data['session'] = session;
    return data;
  }
}
