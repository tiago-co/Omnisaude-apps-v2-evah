class JwtModel {
  String? id;
  String? email;
  List<String>? acessos;
  String? username;
  String? chatbotId;
  String? token;
  String? refreshToken;
  String? redirect;

  JwtModel({
    this.id,
    this.email,
    this.acessos,
    this.username,
    this.chatbotId,
    this.token,
    this.refreshToken,
    this.redirect,
  });

  JwtModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    acessos = json['acessos'].cast<String>();
    username = json['username'];
    chatbotId = json['chatbot_id'];
    token = json['token'];
    refreshToken = json['refresh'];
    redirect = json['redirecionamento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['acessos'] = acessos;
    data['username'] = username;
    data['chatbot_id'] = chatbotId;
    data['token'] = token;
    data['refresh'] = refreshToken;
    data['redirecionamento'] = redirect;
    return data;
  }
}
