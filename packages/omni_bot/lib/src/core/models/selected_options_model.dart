import 'package:omni_bot/src/core/models/option_model.dart';

class SelectedOptionsModel {
  List<OptionModel>? selectedOptions;
  int? min;
  int? max;

  SelectedOptionsModel({
    this.selectedOptions,
    this.max,
    this.min,
  });

  SelectedOptionsModel.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    min = json['min'];
    if (json['selectedOptions'] != null) {
      selectedOptions = List<OptionModel>.empty(growable: true);
      json['selectedOptions'].forEach((v) {
        selectedOptions!.add(OptionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['max'] = max;
    data['min'] = min;
    data['selectedOptions'] = selectedOptions?.map((v) => v.toJson()).toList();

    return data;
  }
}
