import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/blood_pressure_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/heart_rate_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/heart_rhythm_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NurseCardiologicalEvaluationModel {
  String? id;
  BloodPressureType? bloodPressure;
  HeartRateType? heartRate;
  HeartRhythmType? heartRhythm;
  bool? tecMoreThan5s;
  String? note;

  NurseCardiologicalEvaluationModel({
    this.id,
    this.bloodPressure,
    this.heartRate,
    this.heartRhythm,
    this.tecMoreThan5s,
    this.note,
  });

  NurseCardiologicalEvaluationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bloodPressure = bloodPressureTypeFromJson(json['pressao_arterial']);
    heartRate = heartRateTypeFromJson(json['frequencia_cardiaca']);
    heartRhythm = heartRhythmTypeFromJson(json['ritmo_cardiaco']);
    tecMoreThan5s = json['tec_maior_5s'];
    note = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pressao_arterial'] = bloodPressure?.toJson;
    data['frequencia_cardiaca'] = heartRate?.toJson;
    data['ritmo_cardiaco'] = heartRhythm?.toJson;
    data['tec_maior_5s'] = tecMoreThan5s;
    data['observacao'] = note;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['Pressão Arterial'] = buildFieldMap(
      type: 'simple',
      value: bloodPressure?.label,
    );
    bloodPressure;
    data['Frequência Cardiaca'] = buildFieldMap(
      type: 'simple',
      value: heartRate?.label,
    );
    data['Ritmo Cardiaco'] = buildFieldMap(
      type: 'simple',
      value: heartRhythm?.label,
    );
    data['Tect Maior que 5s'] = buildFieldMap(
      type: 'simple',
      value: boolToString(tecMoreThan5s),
    );
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: note,
    );

    return data;
  }
}
