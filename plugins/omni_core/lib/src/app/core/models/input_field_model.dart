import 'package:omni_core/src/app/core/enums/dynamic_form_field_enum.dart';

class InputFieldModel {
  String? id;
  bool? isRequired;
  String? name;
  String? placeholder;
  InputType? inputType;
  KeyboardType? keyboardType;
  String? mask;
  String? answer;

  InputFieldModel({
    this.id,
    this.isRequired,
    this.name,
    this.placeholder,
    this.inputType,
    this.keyboardType,
    this.mask,
    this.answer,
  });

  InputFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isRequired = json['obrigatorio'];
    name = json['nome'];
    placeholder = json['descricao'];
    inputType = inputTypeFromJson(json['tipo']);
    keyboardType = keyboardTypeFromJson(json['tipo_teclado']);
    mask = json['mascara'];
    answer = json['resposta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['obrigatorio'] = isRequired;
    data['nome'] = name;
    data['descricao'] = placeholder;
    data['tipo'] = inputType?.toJson;
    data['tipo_teclado'] = keyboardType?.toJson;
    data['mascara'] = mask;
    data['resposta'] = answer;
    return data;
  }
}
