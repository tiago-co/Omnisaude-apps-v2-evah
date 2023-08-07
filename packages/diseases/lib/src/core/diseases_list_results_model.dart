import 'package:omni_general/omni_general.dart' show ResultsModel;

class DiseasesListResultsModel {
  String? id;
  String? name;
  String? observation;

  DiseasesListResultsModel({
    this.id,
    this.name,
    this.observation,
  });

  DiseasesListResultsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['doenca']['nome'];
    observation = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doenca']['nome'] = name;
    data['observacao'];
    return data;
  }
}

class DiseasesListBaseResults extends ResultsModel {
  List<DiseasesListResultsModel>? results;

  DiseasesListBaseResults({this.results});

  DiseasesListBaseResults.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<DiseasesListResultsModel>.empty(growable: true);
      json['results']
          .forEach((v) => results!.add(DiseasesListResultsModel.fromJson(v)));
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
