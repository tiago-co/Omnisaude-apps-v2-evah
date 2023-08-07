class MultiSelectionModel {
  bool? enabled;
  int? min;
  int? max;

  MultiSelectionModel({this.enabled = false, this.min = 1, this.max});

  MultiSelectionModel.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    min = json['min'] ?? 1;
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}
