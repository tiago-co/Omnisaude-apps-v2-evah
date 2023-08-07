import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/filed_by_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/simple_field_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class GenericEvolutionFormModel extends EvolutionFormModel {
  SimpleFieldModel? overallImpression;

  GenericEvolutionFormModel({this.overallImpression});

  GenericEvolutionFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    evolutionFormType = evolutionFormTypeFromJson(json['tipo']);
    createdAt = json['criado_em'];
    bed = json['leito'];
    attendanceNumber = json['nr_atendimento'];
    filedBy = FiledByModel.fromJson(json['preenchido_por']);
    overallImpression = SimpleFieldModel.fromJson(json['impressao_geral']);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['tipo'] = evolutionFormType?.toJson;
    data['criado_em'] = createdAt;
    data['leito'] = bed;
    data['nr_atendimento'] = attendanceNumber;
    data['preenchido_por'] = filedBy?.toJson();
    data['impressao_geral'] = overallImpression?.toJson();
    return data;
  }

  Map<String, dynamic> getData() {
    Map<String, dynamic> data = {};
    data['Preenchido Por'] = buildFieldMap(
      type: 'simple',
      value: filedBy?.nome,
    );
    data['Impressão Geral'] = buildFieldMap(
      type: 'simple',
      value: overallImpression?.observation,
    );
    return data;
  }
}
