import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/curative_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/healing_aspect_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class InvasiveDeviceItemModel {
  bool? inUse;
  String? local;
  String? insertionDate;
  String? dressingDate;
  CurativeType? curative;
  HealingAspectType? healingAspect;
  String? nextExchangeDate;
  bool? insertedByAnotherInstitution;
  bool? phlebitis;
  bool? palpableShudder;

  InvasiveDeviceItemModel({
    this.inUse,
    this.local,
    this.insertionDate,
    this.dressingDate,
    this.curative,
    this.healingAspect,
    this.nextExchangeDate,
    this.insertedByAnotherInstitution,
    this.phlebitis,
    this.palpableShudder,
  });

  InvasiveDeviceItemModel.fromJson(Map<String, dynamic> json) {
    inUse = json['em_uso'];
    local = json['local'];
    insertionDate = json['data_insercao'];
    dressingDate = json['data_curativo'];
    curative = curativeTypeFromJson(json['curativo']);
    healingAspect = healingAspectTypeFromJson(json['aspecto_do_curativo']);
    nextExchangeDate = json['data_proxima_troca'];
    insertedByAnotherInstitution = json['inserido_em_outra_instituicao'];
    phlebitis = json['flebite'];
    palpableShudder = json['fremito_palpavel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['em_uso'] = inUse;
    data['local'] = local;
    data['data_insercao'] = insertionDate;
    data['data_curativo'] = dressingDate;
    data['curativo'] = curative;
    data['aspecto_do_curativo'] = healingAspect;
    data['data_proxima_troca'] = nextExchangeDate;
    data['inserido_em_outra_instituicao'] = insertedByAnotherInstitution;
    data['flebite'] = phlebitis;
    data['fremito_palpavel'] = palpableShudder;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (inUse != null) {
      data['Em uso'] = buildFieldMap(
        type: 'simple',
        value: boolToString(inUse),
      );
    }
    if (local != null) {
      data['Local'] = buildFieldMap(
        type: 'simple',
        value: local,
      );
    }
    if (insertionDate != null) {
      data['Data da Inserção'] = buildFieldMap(
        type: 'simple',
        value: insertionDate,
      );
    }
    if (dressingDate != null) {
      data['Data do Curativo'] = buildFieldMap(
        type: 'simple',
        value: dressingDate,
      );
    }
    if (curative != null) {
      data['Curativo'] = buildFieldMap(
        type: 'simple',
        value: curative?.label,
      );
    }
    if (healingAspect != null) {
      data['Aspecto do Curativo'] = buildFieldMap(
        type: 'simple',
        value: healingAspect?.label,
      );
    }
    if (nextExchangeDate != null) {
      data['Data da Próxima Troca'] = buildFieldMap(
        type: 'simple',
        value: nextExchangeDate,
      );
    }
    if (insertedByAnotherInstitution != null) {
      data['Inserido em Outra Instituição'] = buildFieldMap(
        type: 'simple',
        value: boolToString(insertedByAnotherInstitution),
      );
    }
    if (phlebitis != null) {
      data['Flebite'] = buildFieldMap(
        type: 'simple',
        value: boolToString(phlebitis),
      );
    }
    if (palpableShudder != null) {
      data['Fremito Palpavel'] = buildFieldMap(
        type: 'simple',
        value: boolToString(palpableShudder),
      );
    }

    return data;
  }
}
