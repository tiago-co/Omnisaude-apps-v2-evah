import 'package:omni_general/omni_general.dart' show ResultsModel;

class CaregiverModel {
  String? id;
  String? name;
  String? cpf;
  List<String>? phones;
  List<String>? emails;
  bool? sendSMS;
  bool? sendEmail;

  CaregiverModel({
    this.id,
    this.name,
    this.cpf,
    this.phones,
    this.emails,
    this.sendSMS,
    this.sendEmail,
  });

  CaregiverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    cpf = json['cpf'];
    phones = json['telefones']?.cast<String>();
    emails = json['emails']?.cast<String>();
    sendSMS = json['envio_sms'];
    sendEmail = json['envio_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['cpf'] = cpf;
    data['telefones'] = phones;
    data['emails'] = emails;
    data['envio_sms'] = sendSMS;
    data['envio_email'] = sendEmail;
    return data;
  }
}

class CaregiverResultsModel extends ResultsModel {
  List<CaregiverModel>? results;

  CaregiverResultsModel({this.results});

  @override
  CaregiverResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <CaregiverModel>[];
      json['results'].forEach((v) {
        results!.add(CaregiverModel.fromJson(v));
      });
    }
    previous = json['previous'];
    next = json['next'];
    offset = json['offset'];
    count = json['count'];
    pageSize = json['page_size'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results?.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
