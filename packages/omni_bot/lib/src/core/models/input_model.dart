import 'package:omni_bot/src/core/enums/input_type_enum.dart';
import 'package:omni_bot/src/core/enums/keyboard_type_enum.dart';

class InputModel {
  InputType? inputType;
  KeyboardType? keyboardType;
  String? mask;

  InputModel({this.inputType, this.keyboardType, this.mask});

  InputModel.fromJson(Map<String, dynamic> json) {
    inputType = inputTypeFromJson(json['inputType']);
    keyboardType = keyboardTypeFromJson(json['keyboardType']);
    mask = json['mask'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inputType'] = inputType?.toJson;
    data['keyboardType'] = keyboardType?.toJson;
    data['mask'] = mask;
    return data;
  }
}
