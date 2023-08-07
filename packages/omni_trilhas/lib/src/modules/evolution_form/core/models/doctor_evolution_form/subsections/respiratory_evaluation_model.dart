import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/respiratory_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/secretion_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/ventilation_types_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class RespiratoryEvaluationModel {
  String? id;
  String? observation;
  List<RespiratoryTypes?>? respiratoryTypes;
  SecretionTypes? secretionType;
  VentilationTypes? ventilationType;
  num? fio2;
  num? peep;
  num? pins;
  num? vc;

  RespiratoryEvaluationModel({
    this.fio2,
    this.id,
    this.observation,
    this.peep,
    this.pins,
    this.respiratoryTypes,
    this.secretionType,
    this.ventilationType,
    this.vc,
  });

  RespiratoryEvaluationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observation = json['observacao'];
    secretionType = secretionTypesFromJson(json['tipo_secrecao']);
    ventilationType = ventilationTypesFromJson(json['tipo_ventilacao']);
    fio2 = json['fio2'];
    peep = json['peep'];
    pins = json['pins'];
    vc = json['vc'];
    if (json['tipos_respiratoria'] != null) {
      respiratoryTypes = List<RespiratoryTypes>.empty(growable: true);
      json['tipos_respiratoria'].forEach((respiratoryType) =>
          respiratoryTypes?.add(respiratoryTypeFromJson(respiratoryType)));
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['observacao'] = observation;
    data['tipo_secrecao'] = secretionType?.toJson;
    data['tipo_ventilacao'] = ventilationType?.toJson;
    data['fio2'] = fio2;
    data['peep'] = peep;
    data['pins'] = pins;
    data['vc'] = vc;
    data['tipos_diagnostico'] =
        respiratoryTypes?.map((v) => v?.toJson).toList();
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> extraData = <String, dynamic>{};
    extraData['Observação'] = buildFieldMap(
      type: 'simple',
      value: observation,
    );
    extraData['Tipo de Secreção'] = buildFieldMap(
      type: 'simple',
      value: secretionType?.label,
    );
    extraData['Tipo de Sentilação'] = buildFieldMap(
      type: 'simple',
      value: ventilationType?.label,
    );
    extraData['fio2'] = buildFieldMap(
      type: 'simple',
      value: fio2.toString(),
    );
    extraData['peep'] = buildFieldMap(
      type: 'simple',
      value: peep.toString(),
    );
    extraData['pins'] = buildFieldMap(
      type: 'simple',
      value: pins.toString(),
    );
    extraData['vc'] = buildFieldMap(
      type: 'simple',
      value: vc.toString(),
    );
    extraData['Tipos'] = buildFieldMap(
      type: 'list',
      value: respiratoryTypes?.map((v) => v?.label).toList(),
    );
    return extraData;
  }
}
