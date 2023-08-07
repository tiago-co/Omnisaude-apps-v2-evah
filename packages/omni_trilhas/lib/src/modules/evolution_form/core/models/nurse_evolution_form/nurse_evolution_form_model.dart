import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/filed_by_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/invasive_devices.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/neurological_assessment_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/nurse_cardiological_evaluation_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/nurse_evaluation_ventilation_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/nurse_genital_assessment_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/nurse_global_assessment_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/nurse_abdominal_evaluation_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/nutritional_therapy_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/pendencies_model.dart';

class NurseEvolutionFormModel extends EvolutionFormModel {
  NurseGlobalAssessmentModel? globalAssessment;
  NurseAbdominalEvaluationModel? abdominalEvaluation;
  NurseCardiologicalEvaluationModel? cardiologicalEvaluation;
  NeurologicalAssessmentModel? neurologicalAssessment;
  NutritionalTherapyModel? nutritionalTherapy;
  NurseEvaluationVentilationModel? evaluationVentilation;
  PendenciesModel? pendencies;
  InvasiveDevicesModel? invasiveDevices;
  NurseGenitalAssessmentModel? genitalAssessment;

  NurseEvolutionFormModel({
    this.globalAssessment,
    this.abdominalEvaluation,
    this.cardiologicalEvaluation,
    this.neurologicalAssessment,
    this.nutritionalTherapy,
    this.evaluationVentilation,
    this.pendencies,
    this.invasiveDevices,
    this.genitalAssessment,
  });

  NurseEvolutionFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    evolutionFormType = evolutionFormTypeFromJson(json['tipo']);
    createdAt = json['criado_em'];
    bed = json['leito'];
    attendanceNumber = json['nr_atendimento'];
    globalAssessment =
        NurseGlobalAssessmentModel.fromJson(json['avaliacao_global']);
    invasiveDevices =
        InvasiveDevicesModel.fromJson(json['dispositivos_invasivos']);
    abdominalEvaluation =
        NurseAbdominalEvaluationModel.fromJson(json['avaliacao_abdominal']);
    genitalAssessment =
        NurseGenitalAssessmentModel.fromJson(json['avaliacao_genital']);
    cardiologicalEvaluation = NurseCardiologicalEvaluationModel.fromJson(
        json['avaliacao_cardiologica']);
    neurologicalAssessment =
        NeurologicalAssessmentModel.fromJson(json['avaliacao_neurologica']);
    nutritionalTherapy =
        NutritionalTherapyModel.fromJson(json['terapia_nutricional']);
    evaluationVentilation =
        NurseEvaluationVentilationModel.fromJson(json['avaliacao_ventilacao']);
    pendencies = PendenciesModel.fromJson(json['pendencias']);
    filedBy = FiledByModel.fromJson(json['preenchido_por']);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = evolutionFormType?.toJson;
    data['criado_em'] = createdAt;
    data['leito'] = bed;
    data['avaliacao_global'] = globalAssessment?.toJson();
    data['dispositivos_invasivos'] = invasiveDevices?.toJson();
    data['avaliacao_abdominal'] = abdominalEvaluation?.toJson();
    data['avaliacao_genital'] = genitalAssessment?.toJson();
    data['avaliacao_cardiologica'] = cardiologicalEvaluation?.toJson();
    data['avaliacao_neurologica'] = neurologicalAssessment?.toJson();
    data['terapia_nutricional'] = nutritionalTherapy?.toJson();
    data['avaliacao_ventilacao'] = evaluationVentilation?.toJson();
    data['pendencias'] = pendencies?.toJson();
    data['preenchido_por'] = filedBy?.toJson();
    return data;
  }
}
