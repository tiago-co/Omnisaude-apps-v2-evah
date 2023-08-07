import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NurseGenitalAssessmentModel {
  String? id;
  String? note;
  bool? edemaScrotalPouch;
  bool? injuries;
  String? descriptionInjury;
  bool? urethralSecretion;
  String? aspect;
  bool? vaginalSecretion;
  String? toDescribe;

  NurseGenitalAssessmentModel({
    this.id,
    this.note,
    this.edemaScrotalPouch,
    this.injuries,
    this.descriptionInjury,
    this.urethralSecretion,
    this.aspect,
    this.vaginalSecretion,
    this.toDescribe,
  });

  NurseGenitalAssessmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['observacao'];
    edemaScrotalPouch = json['edema_bolsa_escrotal'];
    injuries = json['lesoes'];
    descriptionInjury = json['descricao_lesao'];
    urethralSecretion = json['secrecao_uretral'];
    aspect = json['aspecto'];
    vaginalSecretion = json['secrecao_vaginal'];
    toDescribe = json['descrever'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacao'] = note;
    data['edema_bolsa_escrotal'] = edemaScrotalPouch;
    data['lesoes'] = injuries;
    data['descricao_lesao'] = descriptionInjury;
    data['secrecao_uretral'] = urethralSecretion;
    data['aspecto'] = aspect;
    data['secrecao_vaginal'] = vaginalSecretion;
    data['descrever'] = toDescribe;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: note,
    );
    data['edema_bolsa_escrotal'] = buildFieldMap(
      type: 'simple',
      value: boolToString(edemaScrotalPouch),
    );
    data['Lesões'] = buildFieldMap(
      type: 'simple',
      value: boolToString(injuries),
    );
    data['Descrição de Lesão'] = buildFieldMap(
      type: 'simple',
      value: descriptionInjury,
    );
    data['Secreção Uretal'] = buildFieldMap(
      type: 'simple',
      value: boolToString(urethralSecretion),
    );
    data['Aspecto'] = buildFieldMap(
      type: 'simple',
      value: aspect,
    );
    data['Secreção Vaginal'] = buildFieldMap(
      type: 'simple',
      value: boolToString(vaginalSecretion),
    );
    data['Descrição'] = buildFieldMap(
      type: 'simple',
      value: toDescribe,
    );
    return data;
  }
}
