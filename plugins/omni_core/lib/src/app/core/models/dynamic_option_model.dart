class DynamicOptionModel {
  String? id;
  String? title;
  String? subtitle;
  String? image;

  DynamicOptionModel({this.id, this.title, this.subtitle, this.image});

  DynamicOptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['titulo'];
    subtitle = json['subtitulo'];
    image = json['imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = title;
    data['subtitulo'] = subtitle;
    data['imagem'] = image;
    return data;
  }
}
