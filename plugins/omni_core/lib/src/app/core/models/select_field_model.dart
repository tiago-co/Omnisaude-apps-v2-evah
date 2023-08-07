import 'package:omni_bot/omni_bot.dart';

import 'package:omni_core/src/app/core/models/dynamic_multi_selection_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_option_model.dart';

class SelectFieldModel {
  String? id;
  bool? isRequired;
  String? name;
  String? placeholder;
  SelectType? selectType;
  RenderType? renderType;
  DynamicMultiSelectionModel? multiSelection;
  bool? selected;
  Layout? layout;
  List<DynamicOptionModel>? options;
  String? answer;

  SelectFieldModel({
    this.id,
    this.isRequired,
    this.name,
    this.placeholder,
    this.selectType,
    this.renderType,
    this.multiSelection,
    this.selected = false,
    this.layout,
    this.options,
    this.answer,
  });

  SelectFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isRequired = json['obrigatorio'];
    name = json['nome'];
    placeholder = json['descricao'];
    selectType = selectTypeFromJson(json['tipo']);
    renderType = renderTypeFromJson(json['tipo_renderizacao']);
    if (json['multi_selecao'] != null) {
      multiSelection = DynamicMultiSelectionModel.fromJson(
        json['multi_selecao'],
      );
    } else {
      multiSelection = null;
    }
    layout = layoutFromJson(json['layout']);
    if (json['opcoes'] != null) {
      options = List<DynamicOptionModel>.empty(growable: true);
      json['opcoes'].forEach((v) {
        options!.add(DynamicOptionModel.fromJson(v));
      });
    }
    answer = json['resposta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['obrigatorio'] = isRequired;
    data['nome'] = name;
    data['descricao'] = placeholder;
    data['tipo'] = selectType?.toJson;
    data['tipo_renderizacao'] = renderType?.toJson;
    data['multi_selecao'] = multiSelection?.toJson();
    data['layout'] = layout?.toJson;
    data['opcoes'] = options?.map((v) => v.toJson()).toList();
    data['resposta'] = answer;
    return data;
  }
}
