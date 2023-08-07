import 'package:omni_general/src/core/models/results_model.dart';

class FilterModel {
  String? value;

  FilterModel({
    this.value,
  });

  FilterModel.fromJson(Map<String, dynamic> json, String key) {
    value = json[key];
  }

  Map<String, dynamic> toJson(String key) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[key] = value;
    return data;
  }
}

class FilterResultsModel extends ResultsModel {
  List<FilterModel>? results;

  FilterResultsModel({this.results});

  @override
  FilterResultsModel.fromJson(Map<String, dynamic> json, String key) {
    if (json['results'] != null) {
      results = <FilterModel>[];
      json['results'].forEach((v) {
        results!.add(FilterModel.fromJson(v, key));
      });
    }
    previous = json['previous'];
    next = json['next'];
    offset = json['offset'];
    count = json['count'];
    pageSize = json['page_size'];
  }

  @override
  Map<String, dynamic> toJson([String? key]) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results?.map((v) => v.toJson(key!)).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
