class NewJwtModel {
  int? id;
  String? token;
  String? refreshToken;

  NewJwtModel({
    this.id,
    this.token,
    this.refreshToken,
  });

  NewJwtModel.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    token = json['access'];
    refreshToken = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = id;
    data['access'] = token;
    data['refresh'] = refreshToken;
    return data;
  }
}
