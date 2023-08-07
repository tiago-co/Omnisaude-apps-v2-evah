import 'package:omni_general/omni_general.dart' show ResultsModel;

class AllergiesListResultsModel {
  String? id;
  String? name;
  String? observation;

  AllergiesListResultsModel({
    this.id,
    this.name,
    this.observation,
  });

  AllergiesListResultsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    observation = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['observacao'] ;
    return data;
  }
}

class AllergiesListBaseResults extends ResultsModel {
  List<AllergiesListResultsModel>? results;

  AllergiesListBaseResults({this.results});

  AllergiesListBaseResults.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<AllergiesListResultsModel>.empty(growable: true);
      json['results']
          .forEach((v) => results!.add(AllergiesListResultsModel.fromJson(v)));
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
