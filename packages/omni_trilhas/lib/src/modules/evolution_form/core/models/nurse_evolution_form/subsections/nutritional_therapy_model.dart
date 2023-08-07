import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/acceptation_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/prophylaxis_indication_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NutritionalTherapyModel {
  String? id;
  bool? dietZero;
  bool? dietOral;
  bool? enteralSneGtt;
  AcceptationType? acceptance;
  bool? parentalNutrition;
  int? vomiting;
  int? gastricResidue;
  int? hgtMax;
  int? hgtMin;
  ProphylaxisIndicationType? indicationProphylaxis;

  NutritionalTherapyModel({
    this.id,
    this.dietZero,
    this.dietOral,
    this.enteralSneGtt,
    this.acceptance,
    this.parentalNutrition,
    this.vomiting,
    this.gastricResidue,
    this.hgtMax,
    this.hgtMin,
    this.indicationProphylaxis,
  });

  NutritionalTherapyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dietZero = json['dieta_zero'];
    dietOral = json['dieta_via_oral'];
    enteralSneGtt = json['enteral_sne_gtt'];
    acceptance = acceptationFromJson(json['aceitacao']);
    parentalNutrition = json['nutricao_parental'];
    vomiting = json['vomitos'];
    gastricResidue = json['residuo_gastrico'];
    hgtMax = json['hgt_max'];
    hgtMin = json['hgt_min'];
    indicationProphylaxis =
        prophylaxisIndicationTypeFromJson(json['indicacao_profilaxia']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dieta_zero'] = dietZero;
    data['dieta_via_oral'] = dietOral;
    data['enteral_sne_gtt'] = enteralSneGtt;
    data['aceitacao'] = acceptance;
    data['nutricao_parental'] = parentalNutrition;
    data['vomitos'] = vomiting;
    data['residuo_gastrico'] = gastricResidue;
    data['hgt_max'] = hgtMax;
    data['hgt_min'] = hgtMin;
    data['indicacao_profilaxia'] = indicationProphylaxis;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Dieta Zero'] = buildFieldMap(
      type: 'simple',
      value: boolToString(dietZero),
    );

    data['Dieta Via Oral'] = buildFieldMap(
      type: 'simple',
      value: boolToString(dietOral),
    );

    data['Enteral SNE GTT'] = buildFieldMap(
      type: 'simple',
      value: boolToString(enteralSneGtt),
    );
    data['Aceitação'] = buildFieldMap(
      type: 'simple',
      value: acceptance?.label,
    );
    data['Nutrição Parental'] = buildFieldMap(
      type: 'simple',
      value: boolToString(parentalNutrition),
    );
    data['Vômitos'] = buildFieldMap(
      type: 'simple',
      value: vomiting.toString(),
    );
    data['Residuo Gastrico'] = buildFieldMap(
      type: 'simple',
      value: gastricResidue.toString(),
    );
    data['HGT Máximo'] = buildFieldMap(
      type: 'simple',
      value: hgtMax.toString(),
    );
    data['HGT Mínimo'] = buildFieldMap(
      type: 'simple',
      value: hgtMin.toString(),
    );
    data['Indicação de Profilaxia'] = buildFieldMap(
      type: 'simple',
      value: indicationProphylaxis?.label,
    );
    return data;
  }
}
