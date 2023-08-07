import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/general_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/hydroair_noises_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/pain_presence_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NurseAbdominalEvaluationModel {
  String? id;
  List<GeneralType?>? general;
  List<HydroairNoiosesType?>? hydroaerialNoises;
  List<PainPresenceType?>? presence;
  bool? palpableMasses;
  bool? peristalsis;
  String? type;
  String? place;
  String? note;

  NurseAbdominalEvaluationModel({
    this.id,
    this.general,
    this.hydroaerialNoises,
    this.presence,
    this.palpableMasses,
    this.peristalsis,
    this.type,
    this.place,
    this.note,
  });

  NurseAbdominalEvaluationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['geral'] != null) {
      general = List<GeneralType>.empty(growable: true);
      json['geral'].forEach((v) => general?.add(generalTypeFromJson(v)));
    }
    if (json['ruidos_hidroaereos'] != null) {
      hydroaerialNoises = List<HydroairNoiosesType>.empty(growable: true);
      json['ruidos_hidroaereos'].forEach(
          (v) => hydroaerialNoises?.add(hydroairNoiosesTypeFromJson(v)));
    }
    if (json['presenca_dor'] != null) {
      presence = List<PainPresenceType>.empty(growable: true);
      json['presenca_dor']
          .forEach((v) => presence?.add(painPresenceTypeFromJson(v)));
    }
    palpableMasses = json['massas_palpaveis'];
    peristalsis = json['peristalse'];
    type = json['tipo'];
    place = json['local'];
    note = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['geral'] = general;
    data['ruidos_hidroaereos'] = hydroaerialNoises;
    data['presenca_dor'] = presence;
    data['massas_palpaveis'] = palpableMasses;
    data['peristalse'] = peristalsis;
    data['tipo'] = type;
    data['local'] = place;
    data['observacao'] = note;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Geral'] = buildFieldMap(
      type: 'list',
      value: general?.map((e) => e?.label).toList(),
    );
    data['Ruídos Hidroaéreos'] = buildFieldMap(
      type: 'list',
      value: hydroaerialNoises?.map((e) => e?.label).toList(),
    );
    data['Presença de Dor'] = buildFieldMap(
      type: 'list',
      value: presence?.map((e) => e?.label).toList(),
    );
    data['Massa Palpáveis'] = buildFieldMap(
      type: 'simple',
      value: boolToString(palpableMasses),
    );
    data['Peristalse'] = buildFieldMap(
      type: 'simple',
      value: boolToString(peristalsis),
    );
    data['Tipo'] = buildFieldMap(
      type: 'simple',
      value: type,
    );
    data['Local'] = buildFieldMap(
      type: 'simple',
      value: place,
    );
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: note,
    );
    return data;
  }
}
