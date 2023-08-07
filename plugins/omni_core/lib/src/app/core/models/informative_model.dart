import 'package:omni_core/src/app/core/enums/informative_type_enum.dart';
import 'package:omni_general/omni_general.dart';

class InformativeModel {
  String? id;
  String? banner;
  String? title;
  String? content;
  String? createdAt;
  String? url;
  String? updatedAt;
  InformativeType? type;

  InformativeModel({
    this.id,
    this.banner,
    this.title,
    this.content,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  InformativeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    title = json['titulo'];
    content = json['conteudo'];
    url = json['anexo'];
    createdAt = json['criado_em'];
    updatedAt = json['modificado_em'];
    type = informativeTypeFromJson(json['tipo_conteudo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['anexo'] = url;
    data['titulo'] = title;
    data['banner'] = banner;
    data['conteudo'] = content;
    data['criado_em'] = createdAt;
    data['modificado_em'] = updatedAt;
    data['tipo_conteudo'] = type?.toJson;
    return data;
  }
}

class MediktorInformativeResultsModel extends ResultsModel {
  List<InformativeModel>? results;

  MediktorInformativeResultsModel({this.results});

  @override
  MediktorInformativeResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['informativos'] != null) {
      results = List<InformativeModel>.empty(growable: true);
      json['informativos'].forEach((v) {
        results!.add(InformativeModel.fromJson(v));
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
    data['informativos'] = results?.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}

class InformativeResultsModel extends ResultsModel {
  List<InformativeModel>? results;

  InformativeResultsModel({this.results});

  @override
  InformativeResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<InformativeModel>.empty(growable: true);
      json['results'].forEach((v) {
        results!.add(InformativeModel.fromJson(v));
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
