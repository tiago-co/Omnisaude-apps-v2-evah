import 'package:omni_general/omni_general.dart';

class CategoryInformativeModel {
  String? id;
  String? banner;
  String? name;
  String? description;

  CategoryInformativeModel({
    this.id,
    this.banner,
    this.name,
    this.description,
  });

  CategoryInformativeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    name = json['nome'];
    description = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['banner'] = banner;
    data['descricao'] = description;
    return data;
  }
}

class CategoryInformativeModelResultsModel extends ResultsModel {
  List<CategoryInformativeModel>? results;

  CategoryInformativeModelResultsModel({this.results});

  @override
  CategoryInformativeModelResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<CategoryInformativeModel>.empty(growable: true);
      json['results'].forEach((v) {
        results!.add(CategoryInformativeModel.fromJson(v));
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
