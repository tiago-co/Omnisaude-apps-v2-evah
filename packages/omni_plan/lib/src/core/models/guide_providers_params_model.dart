class GuideProvidersParamsModel {
  String? name;
  String? specialty;
  String? limit;
  String? address;
  bool? favorites;

  GuideProvidersParamsModel({
    this.name,
    this.specialty,
    this.limit,
    this.address,
    this.favorites,
  });

  GuideProvidersParamsModel.fromJson(Map<String, dynamic> json) {
    name = json['nome'];
    specialty = json['especialidade'];
    limit = json['limit'];
    address = json['estado'];
    favorites = json['favoritos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = name;
    data['especialidade'] = specialty;
    data['limit'] = limit;
    data['estado'] = address;
    data['favoritos'] = favorites;
    return data;
  }
}
