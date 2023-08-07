import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/exams_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class PhysicalExamModel {
  String? id;
  String? observation;
  List<ExamsTypes?>? examsTypes;

  PhysicalExamModel({
    this.examsTypes,
    this.id,
    this.observation,
  });

  PhysicalExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observation = json['observacao'];
    if (json['tipos_exame'] != null) {
      examsTypes = List<ExamsTypes>.empty(growable: true);
      json['tipos_exame'].forEach(
          (examsType) => examsTypes?.add(examsTypesFromJson(examsType)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacao'] = observation;
    data['exame_fisico'] = examsTypes?.map((v) => v?.toJson).toList();
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: observation,
    );
    data['Exame Físico'] = buildFieldMap(
      type: 'list',
      value: examsTypes?.map((v) => v?.label).toList(),
    );
    return data;
  }
}
