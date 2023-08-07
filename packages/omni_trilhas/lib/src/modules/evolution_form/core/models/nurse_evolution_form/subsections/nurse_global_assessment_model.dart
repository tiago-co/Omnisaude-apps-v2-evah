import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/assistance_risk_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/edema_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/general_state_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/precautions_isolation_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NurseGlobalAssessmentModel {
  String? id;
  EdemaType? edema;
  GeneralStateType? generalState;
  bool? pale;
  bool? jaundice;
  bool? fever;
  bool? cyanosis;
  List<AssistanceRiskType?>? assistanceRisk;
  List<PrecautionIsolationType?>? precautionIsolation;
  bool? ulcerationsCurative;
  String? coverage;
  String? locationUsage;

  NurseGlobalAssessmentModel({
    this.id,
    this.edema,
    this.generalState,
    this.pale,
    this.jaundice,
    this.fever,
    this.cyanosis,
    this.ulcerationsCurative,
    this.coverage,
    this.locationUsage,
    this.assistanceRisk,
    this.precautionIsolation,
  });

  NurseGlobalAssessmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    edema = edemaTypeFromJson(json['edema']);
    generalState = generalStateFromjson(json['estado_geral']);
    pale = json['hipocorado'];
    jaundice = json['ictericia'];
    fever = json['febre'];
    cyanosis = json['cianose'];
    ulcerationsCurative = json['ulceracoes_curativo'];
    coverage = json['cobertura'];
    locationUsage = json['localizacao_uso'];
    if (json['riscos_assistenciais'] != null) {
      assistanceRisk = List<AssistanceRiskType>.empty(growable: true);
      json['riscos_assistenciais'].forEach(
          (type) => assistanceRisk?.add(assistanceRiskTypeFromJson(type)));
    }
    if (json['precaucoes_isolamento'] != null) {
      precautionIsolation = List<PrecautionIsolationType>.empty(growable: true);
      json['precaucoes_isolamento'].forEach((type) =>
          precautionIsolation?.add(precautionIsolationTypeFromJson(type)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['edema'] = edema;
    data['estado_geral'] = generalState;
    data['hipocorado'] = pale;
    data['ictericia'] = jaundice;
    data['febre'] = fever;
    data['cianose'] = cyanosis;
    data['ulceracoes_curativo'] = ulcerationsCurative;
    data['cobertura'] = coverage;
    data['localizacao_uso'] = locationUsage;
    data['riscos_assistenciais'] =
        assistanceRisk?.map((v) => v?.toJson).toList();
    data['precaucoes_isolamento'] =
        precautionIsolation?.map((v) => v?.toJson).toList();
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['Edema'] = buildFieldMap(
      type: 'simple',
      value: edema?.label,
    );
    data['Estado Geral'] = buildFieldMap(
      type: 'simple',
      value: generalState?.label,
    );
    data['Hipocorado'] = buildFieldMap(
      type: 'simple',
      value: boolToString(pale),
    );
    data['Icterícia'] = buildFieldMap(
      type: 'simple',
      value: boolToString(jaundice),
    );
    data['Febre'] = buildFieldMap(
      type: 'simple',
      value: boolToString(fever),
    );
    data['cianose'] = buildFieldMap(
      type: 'simple',
      value: boolToString(cyanosis),
    );
    data['Ulcerações curativo'] = buildFieldMap(
      type: 'simple',
      value: boolToString(ulcerationsCurative),
    );
    data['Cobertura'] = buildFieldMap(
      type: 'simple',
      value: coverage,
    );
    data['Localização de Uso'] = buildFieldMap(
      type: 'simple',
      value: locationUsage,
    );
    data['Riscos Assistenciais'] = buildFieldMap(
      type: 'list',
      value: assistanceRisk?.map((v) => v?.label).toList(),
    );
    data['Precauções de Isolamento'] = buildFieldMap(
      type: 'list',
      value: precautionIsolation?.map((v) => v?.label).toList(),
    );

    return data;
  }
}
