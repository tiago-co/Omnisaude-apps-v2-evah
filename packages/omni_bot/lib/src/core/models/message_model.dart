import 'package:omni_bot/src/core/enums/message_type_enum.dart';

class MessageModel {
  MessageType? messageType;
  String? value;

  /// Component [extras] representa o atributo de resposta para uma seleção
  /// de uma lista de [Option] no modelo de [SwitchContent].
  Map<String, dynamic>? extras;

  MessageModel({this.messageType, this.value, this.extras});

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageType = messageTypeFromJson(json['messageType']);
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageType'] = messageType?.toJson;
    data['value'] = value;
    data['extras'] = extras;
    return data;
  }
}
