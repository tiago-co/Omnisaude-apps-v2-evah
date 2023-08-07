import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NeurologicalEvalutationModel {
  String? id;
  String? observation;
  int? glasgowComaScale;

  NeurologicalEvalutationModel({
    this.glasgowComaScale,
    this.id,
    this.observation,
  });

  NeurologicalEvalutationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observation = json['observacao'];
    glasgowComaScale = json['escala_coma_glasgow'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['observacao'] = observation;
    data['escala_coma_glasgow'] = glasgowComaScale;
    return data;
  }

  Map<String, dynamic> getData() {
    Map<String, dynamic> data = {};
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: observation,
    );
    data['Escala de Coma de Galsgow'] = buildFieldMap(
      type: 'simple',
      value: glasgowComaScale.toString(),
    );
    return data;
  }
}
