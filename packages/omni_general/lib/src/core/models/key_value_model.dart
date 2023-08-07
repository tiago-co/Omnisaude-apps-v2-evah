import 'package:omni_general/src/core/models/results_model.dart';

class KeyValueModel {
  String? id;
  String? key;
  String? value;

  KeyValueModel({
    this.id,
    this.key,
    this.value,
  });

  KeyValueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['valor'] = value;
    return data;
  }
}


class KeyValueResultsModel extends ResultsModel {
  List<KeyValueModel>? results;

  KeyValueResultsModel({this.results});

  @override
  KeyValueResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <KeyValueModel>[];
      json['results'].forEach((v) {
        results!.add(KeyValueModel.fromJson(v));
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
