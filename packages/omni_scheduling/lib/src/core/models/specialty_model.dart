import 'package:omni_general/omni_general.dart' show ResultsModel;

class SpecialtyModel {
  String? id;
  String? name;

  SpecialtyModel({
    this.id,
    this.name,
  });

  SpecialtyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    return data;
  }
}
class SpecialtyResults extends ResultsModel {
  List<SpecialtyModel>? results;

  SpecialtyResults({this.results});

  SpecialtyResults.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<SpecialtyModel>.empty(growable: true);
      json['results'].forEach((v) => results!.add(SpecialtyModel.fromJson(v)));
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
