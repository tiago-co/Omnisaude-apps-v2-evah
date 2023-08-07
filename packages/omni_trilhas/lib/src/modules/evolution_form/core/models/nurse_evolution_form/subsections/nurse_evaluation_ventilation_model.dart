import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/aspect_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/aspect_secretion_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/auscultate_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/chest_drain_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/cough_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/healing_aspect_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/lung_expansion_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/secretion_tracheal_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NurseEvaluationVentilationModel {
  String? id;
  SecretionTrachealType? trachealSecretion;
  AspectType? aspect;
  CoughType? cough;
  LungExpansionType? lungExpansion;
  ChestDrainType? thoraxDrain;
  bool? oscillation;
  AspectSecretionType? aspectOfSecretion;
  HealingAspectType? healingAspect;
  AuscultateType? auscultation;
  String? sealExchangeDate;
  String? note;

  NurseEvaluationVentilationModel({
    this.id,
    this.trachealSecretion,
    this.aspect,
    this.cough,
    this.lungExpansion,
    this.thoraxDrain,
    this.oscillation,
    this.aspectOfSecretion,
    this.healingAspect,
    this.auscultation,
    this.sealExchangeDate,
    this.note,
  });

  NurseEvaluationVentilationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trachealSecretion =
        secretionTrachealTypeFromJson(json['secrecao_traqueal']);
    aspect = aspectTypeFromJson(json['aspecto']);
    cough = coughTypeFromJson(json['tosse']);
    lungExpansion = lungExpansionFromJson(json['expansibilidade_pulmonar']);
    thoraxDrain = chestDrainTypeFromJson(json['dreno_de_torax']);
    oscillation = json['oscilacao'];
    aspectOfSecretion =
        aspectSecretionTypeFromJson(json['aspecto_da_secrecao']);
    healingAspect = healingAspectTypeFromJson(json['aspecto_do_curativo']);
    auscultation = auscultateTypeFromJson(json['ausculta']);
    sealExchangeDate = json['data_troca_selo'];
    note = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['secrecao_traqueal'] = trachealSecretion?.toJson;
    data['aspecto'] = aspect?.toJson;
    data['tosse'] = cough?.toJson;
    data['expansibilidade_pulmonar'] = lungExpansion?.toJson;
    data['dreno_de_torax'] = thoraxDrain?.toJson;
    data['oscilacao'] = oscillation;
    data['aspecto_da_secrecao'] = aspectOfSecretion?.toJson;
    data['aspecto_do_curativo'] = healingAspect?.toJson;
    data['ausculta'] = auscultation?.toJson;
    data['data_troca_selo'] = sealExchangeDate;
    data['observacao'] = note;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Secreção Traqueal'] = buildFieldMap(
      type: 'simple',
      value: trachealSecretion?.label,
    );
    data['Aspect'] = buildFieldMap(
      type: 'simple',
      value: aspect?.label,
    );
    data['Tosse'] = buildFieldMap(
      type: 'simple',
      value: cough?.label,
    );
    data['Expansibilidade Pulmonar'] = buildFieldMap(
      type: 'simple',
      value: lungExpansion?.label,
    );
    data['Dreno de tórax'] = buildFieldMap(
      type: 'simple',
      value: thoraxDrain?.label,
    );
    data['Oscilação'] = buildFieldMap(
      type: 'simple',
      value: boolToString(oscillation),
    );
    data['Aspecto da secreção'] = buildFieldMap(
      type: 'simple',
      value: aspectOfSecretion?.label,
    );
    data['Aspecto do curativo'] = buildFieldMap(
      type: 'simple',
      value: healingAspect?.label,
    );
    data['Ausculta'] = buildFieldMap(
      type: 'simple',
      value: auscultation?.label,
    );
    data['Data de troca do selo'] = buildFieldMap(
      type: 'simple',
      value: sealExchangeDate,
    );
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: note,
    );
    return data;
  }
}
