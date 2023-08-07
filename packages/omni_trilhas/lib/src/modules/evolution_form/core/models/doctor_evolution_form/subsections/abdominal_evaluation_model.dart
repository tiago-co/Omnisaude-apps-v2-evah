import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/abdominal_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class AbdominalEvaluationModel {
  String? id;
  String? observation;
  List<AbdominalTypes?>? abdominalTypes;

  AbdominalEvaluationModel({
    this.abdominalTypes,
    this.id,
    this.observation,
  });

  AbdominalEvaluationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observation = json['observacao'];
    if (json['tipos_abdominal'] != null) {
      abdominalTypes = List<AbdominalTypes>.empty(growable: true);
      json['tipos_abdominal'].forEach((cardiologicType) =>
          abdominalTypes?.add(abdominalTypesFromJson(cardiologicType)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacao'] = observation;
    data['tipos_abdominal'] = abdominalTypes?.map((v) => v?.toJson).toList();
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: observation,
    );
    data['Tipos'] = buildFieldMap(
      type: 'list',
      value: abdominalTypes?.map((v) => v?.label).toList(),
    );
    return data;
  }
}
