import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/diagnostic_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class DiagnosticDoctorModel {
  String? id;
  String? observation;
  List<DiagnosticTypes?>? diagnosticTypes;

  DiagnosticDoctorModel({
    this.id,
    this.diagnosticTypes,
    this.observation,
  });

  DiagnosticDoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observation = json['observacao'];
    if (json['tipos_diagnostico'] != null) {
      diagnosticTypes = List<DiagnosticTypes>.empty(growable: true);
      json['tipos_diagnostico'].forEach((diagnosticType) =>
          diagnosticTypes?.add(diagnosticTypesFromJson(diagnosticType)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacao'] = observation;
    data['tipos_diagnostico'] = diagnosticTypes?.map((v) => v?.toJson).toList();
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
      value: diagnosticTypes?.map((v) => v?.label).toList(),
    );
    return data;
  }
}
