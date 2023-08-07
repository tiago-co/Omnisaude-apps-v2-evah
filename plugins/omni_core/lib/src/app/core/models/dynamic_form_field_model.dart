import 'package:omni_core/src/app/core/enums/dynamic_form_field_enum.dart';
import 'package:omni_core/src/app/core/models/input_field_model.dart';

import 'package:omni_core/src/app/core/models/select_field_model.dart';
import 'package:omni_core/src/app/core/models/upload_field_model.dart';

class DynamicFormFieldModel {
  String? id;
  DynamicFormType? type;
  InputFieldModel? inputField;
  UploadFieldModel? uploadField;
  SelectFieldModel? selectField;

  DynamicFormFieldModel({
    this.id,
    this.type,
    this.inputField,
    this.uploadField,
    this.selectField,
  });

  DynamicFormFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = dynamicFormTypeFromJson(json['tipo']);
    if (json['input'] != null) {
      inputField = InputFieldModel.fromJson(json['input']);
    } else {
      inputField = null;
    }
    if (json['upload'] != null) {
      uploadField = UploadFieldModel.fromJson(json['upload']);
    } else {
      uploadField = null;
    }
    if (json['selecao'] != null) {
      selectField = SelectFieldModel.fromJson(json['selecao']);
    } else {
      selectField = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = type?.toJson;
    data['input'] = inputField?.toJson();
    data['upload'] = uploadField?.toJson();
    data['selecao'] = selectField?.toJson();
    return data;
  }
}
