import 'package:omni_general/omni_general.dart' show ResultsModel;

class MedicineBaseModel {
  int? id;
  String? name;
  String? presentation;

  MedicineBaseModel({
    this.id,
    this.name,
    this.presentation,
  });

  MedicineBaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    presentation = json['apresentacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['apresentacao'] = presentation;
    return data;
  }
}

class MedicineBaseResults extends ResultsModel {
  List<MedicineBaseModel>? results;

  MedicineBaseResults({this.results});

  MedicineBaseResults.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<MedicineBaseModel>.empty(growable: true);
      json['results']
          .forEach((v) => results!.add(MedicineBaseModel.fromJson(v)));
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
