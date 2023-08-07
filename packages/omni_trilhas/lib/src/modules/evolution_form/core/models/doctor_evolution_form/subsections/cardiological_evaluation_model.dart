import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/cardiologic_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class CardiologicalEvaluationModel {
  String? id;
  String? observation;
  List<CardiologicTypes?>? cardiologicTypes;

  CardiologicalEvaluationModel(
      {this.id, this.observation, this.cardiologicTypes});

  CardiologicalEvaluationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observation = json['observacao'];
    if (json['tipos_cardiologica'] != null) {
      cardiologicTypes = List<CardiologicTypes>.empty(growable: true);
      json['tipos_cardiologica'].forEach((cardiologicType) =>
          cardiologicTypes?.add(cardiologicTypesFromJson(cardiologicType)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacao'] = observation;
    data['tipos_cardiologica'] =
        cardiologicTypes?.map((v) => v?.toJson).toList();
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
      value: cardiologicTypes?.map((v) => v?.label).toList(),
    );

    return data;
  }
}
