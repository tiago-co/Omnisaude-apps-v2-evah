class InformativeParamsModel {
  String? name;
  String? title;
  String? limit;
  String? category;

  InformativeParamsModel({
    this.name,
    this.title,
    this.limit,
    this.category,
  });

  InformativeParamsModel.fromJson(Map<String, dynamic> json) {
    name = json['nome'];
    title = json['titulo'];
    limit = json['limit'];
    category = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = name;
    data['titulo'] = title;
    data['limit'] = limit;
    data['categoria'] = category;
    return data;
  }
}
