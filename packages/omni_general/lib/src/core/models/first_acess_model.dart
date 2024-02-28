import 'package:omni_general/src/core/enums/first_acess_send_to_enum.dart';

class FirstAcessModel {
  String? cpfOrEmail;
  FirstAcessType? sendTo;
  int? id = 0;

  FirstAcessModel({
    this.cpfOrEmail,
    this.sendTo = FirstAcessType.whatsApp,
    this.id,
  });

  FirstAcessModel.fromJson(Map<String, dynamic> json) {
    cpfOrEmail = json['cpf_or_email'].toString();
    sendTo = firstAcessTypeFromJson(json['send_to']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpf_or_email'] = cpfOrEmail;
    data['send_to'] = sendTo?.name;
    data['id'] = id;
    return data;
  }
}
