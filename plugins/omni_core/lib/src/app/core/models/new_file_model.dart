class NewFileModel {
  String? name;
  String? b64;

  NewFileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    b64 = json['b64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['b64'] = b64;
    return data;
  }
}
