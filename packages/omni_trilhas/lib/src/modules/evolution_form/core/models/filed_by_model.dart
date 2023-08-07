import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class FiledByModel {
  String? id;
  String? nome;

  FiledByModel({this.id, this.nome});

  FiledByModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = buildFieldMap(
      type: 'simple',
      value: nome,
    );
    return data;
  }
}
