import 'package:omni_general/omni_general.dart';

class NewExamModel {
  String? id;
  String? name;
  String? observation;
  String? file;
  String? filename;

  NewExamModel({
    this.id,
    this.name,
    this.observation,
    this.file,
    this.filename,
  });

  NewExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    observation = json['observacao'];
    file = json['arquivo'];
    filename = json['nome do arquivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['observacao'] = observation;
    data['arquivo'] = file;
    data['nome do arquivo'] = filename;
    return data;
  }
}

class ExamsResultsModel extends ResultsModel {
  List<NewExamModel>? results;

  ExamsResultsModel({this.results});

  @override
  ExamsResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <NewExamModel>[];
      json['results'].forEach((v) {
        results!.add(NewExamModel.fromJson(v));
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
