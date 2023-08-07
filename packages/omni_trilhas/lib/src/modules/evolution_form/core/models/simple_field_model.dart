import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/simple_field_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class SimpleFieldModel {
  String? id;
  String? observation;
  SimpleFieldTypes? contentType;

  SimpleFieldModel({
    this.contentType,
    this.id,
    this.observation,
  });

  SimpleFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observation = json['observacao'];
    contentType = simpleFieldTypesFromJson(json['tipo_conteudo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacao'] = observation;
    data['tipo_conteudo'] = contentType?.toJson;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[contentType!.label] = buildFieldMap(
      type: 'simple',
      value: observation,
    );
    return data;
  }
}
