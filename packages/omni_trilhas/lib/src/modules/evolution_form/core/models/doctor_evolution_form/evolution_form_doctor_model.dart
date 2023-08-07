import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/abdominal_evaluation_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/cardiological_evaluation_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/diagnostic_doctor_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/indicators_24_hours_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/neurological_evaluation_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/physical_exam_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/respiratory_evaluation_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/subsections/vital_signs_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/simple_field_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/filed_by_model.dart';

class EvolutionFormDoctorModel extends EvolutionFormModel {
  String? pdf;
  CardiologicalEvaluationModel? cardiologicalEvaluation;
  DiagnosticDoctorModel? diagnosticDoctor;
  SimpleFieldModel? medicalImpression;
  SimpleFieldModel? therapeuticPlan;
  SimpleFieldModel? medicalConduct;
  Indicators24HoursModel? indicators24Hours;
  VitalSignsModel? vitalSigns;
  RespiratoryEvaluationModel? respiratoryEvaluation;
  NeurologicalEvalutationModel? neurologicalEvalutation;
  AbdominalEvaluationModel? abdominalEvaluation;
  PhysicalExamModel? physicalExam;

  EvolutionFormDoctorModel({
    this.pdf,
    this.cardiologicalEvaluation,
    this.diagnosticDoctor,
    this.medicalConduct,
    this.medicalImpression,
    this.therapeuticPlan,
    this.indicators24Hours,
    this.vitalSigns,
    this.respiratoryEvaluation,
    this.neurologicalEvalutation,
    this.abdominalEvaluation,
    this.physicalExam,
  });

  EvolutionFormDoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    evolutionFormType = evolutionFormTypeFromJson(json['tipo']);
    createdAt = json['criado_em'];
    bed = json['leito'];
    attendanceNumber = json['nr_atendimento'];
    pdf = json['pdf'];
    if (json['avaliacao_cardiologica'] != null) {
      cardiologicalEvaluation =
          CardiologicalEvaluationModel.fromJson(json['avaliacao_cardiologica']);
    }
    diagnosticDoctor = DiagnosticDoctorModel.fromJson(json['diagnostico']);
    medicalConduct = SimpleFieldModel.fromJson(json['conduta_medica']);
    medicalImpression = SimpleFieldModel.fromJson(json['impressao_medica']);
    therapeuticPlan = SimpleFieldModel.fromJson(json['plano_terapeutico']);
    indicators24Hours =
        Indicators24HoursModel.fromJson(json['indicadores_24h']);
    vitalSigns = VitalSignsModel.fromJson(json['sinais_vitais']);
    filedBy = FiledByModel.fromJson(json['preenchido_por']);
    respiratoryEvaluation =
        RespiratoryEvaluationModel.fromJson(json['avaliacao_respiratoria']);
    neurologicalEvalutation =
        NeurologicalEvalutationModel.fromJson(json['avaliacao_neurologica']);
    abdominalEvaluation =
        AbdominalEvaluationModel.fromJson(json['avaliacao_abdominal']);
    physicalExam = PhysicalExamModel.fromJson(json['exame_fisico']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = evolutionFormType?.toJson;
    data['criado_em'] = createdAt;
    data['leito'] = bed;
    data['avaliacao_cardiologica'] = cardiologicalEvaluation?.toJson();
    data['diagnostico'] = diagnosticDoctor?.toJson();
    data['conduta_medica'] = medicalConduct?.toJson();
    data['impressao_medica'] = medicalImpression?.toJson();
    data['plano_terapeutico'] = therapeuticPlan?.toJson();
    data['sinais_vitais'] = vitalSigns?.toJson();
    data['preenchido_por'] = filedBy?.toJson();
    data['avaliacao_respiratoria'] = respiratoryEvaluation?.toJson();
    data['avaliacao_neurologica'] = neurologicalEvalutation?.toJson();
    data['avaliacao_abdominal'] = abdominalEvaluation?.toJson();
    data['exame_fisico'] = physicalExam?.toJson();
    return data;
  }
}
