import 'package:omni_bot/src/core/enums/layout_enum.dart';
import 'package:omni_bot/src/core/enums/render_type_enum.dart';
import 'package:omni_bot/src/core/enums/select_type_enum.dart';

import 'package:omni_bot/src/core/models/multi_selection_model.dart';
import 'package:omni_bot/src/core/models/option_model.dart';

class SelectModel {
  SelectType? selectType;
  RenderType? renderType;
  MultiSelectionModel? multiSelection;
  bool? selected;
  Layout? layout;
  List<OptionModel>? options;

  SelectModel({
    this.selectType,
    this.renderType,
    this.multiSelection,
    this.selected = false,
    this.layout,
    this.options,
  });

  SelectModel.fromJson(Map<String, dynamic> json) {
    selectType = selectTypeFromJson(json['switchType']);
    renderType = renderTypeFromJson(json['renderType']);
    multiSelection = json['multiSelection'] != null
        ? MultiSelectionModel.fromJson(json['multiSelection'])
        : null;
    layout = layoutFromJson(json['layout']);
    if (json['options'] != null) {
      options = List<OptionModel>.empty(growable: true);
      json['options'].forEach((v) {
        options!.add(OptionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['switchType'] = selectType?.toJson;
    data['renderType'] = renderType?.toJson;
    data['multiSelection'] = multiSelection?.toJson();
    data['layout'] = layout?.toJson;
    data['options'] = options?.map((v) => v.toJson()).toList();
    return data;
  }
}
