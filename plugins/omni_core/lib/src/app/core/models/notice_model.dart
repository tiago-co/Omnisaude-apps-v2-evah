import 'package:omni_general/omni_general.dart' show ResultsModel;

class NoticeModel {
  String? id;
  String? title;
  String? content;
  String? banner;
  String? image;
  bool? active;

  NoticeModel({
    this.id,
    this.title,
    this.content,
    this.banner,
    this.image,
    this.active,
  });

  NoticeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['titulo'];
    content = json['conteudo'];
    banner = json['miniatura'];
    image = json['imagem'];
    active = json['ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = title;
    data['conteudo'] = content;
    data['miniatura'] = banner;
    data['image'] = image;
    data['ativo'] = active;
    return data;
  }
}

class NoticeResultsModel extends ResultsModel {
  List<NoticeModel>? results;

  NoticeResultsModel({this.results});

  @override
  NoticeResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<NoticeModel>.empty(growable: true);
      json['results'].forEach((v) {
        results!.add(NoticeModel.fromJson(v));
      });
    }
    previous = json['previous'];
    next = json['next'];
    offset = json['offset'];
    count = json['count'];
    pageSize = json['page_size'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results?.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
