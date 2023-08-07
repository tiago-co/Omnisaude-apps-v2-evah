import 'package:omni_assistance/src/core/enums/assistance_status_enum.dart';
import 'package:omni_general/omni_general.dart';

class AssistanceModel {
  String? id;
  String? contact;
  String? note;
  String? subject;
  String? serviceObservation;
  AssistanceStatus? status;

  AssistanceModel({
    this.id,
    this.contact,
    this.note,
    this.subject,
    this.serviceObservation,
    this.status,
  });

  AssistanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contact = json['contato'];
    note = json['observacao'];
    subject = json['assunto'];
    if (json['status'] != null) {
      status = assistanceStatusFromJson(json['status']);
    } else {
      status = null;
    }
    serviceObservation = json['observacao_atendimento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contato'] = contact;
    data['observacao'] = note;
    data['assunto'] = subject;
    data['status'] = status?.toJson;
    data['observacao_atendimento'] = serviceObservation;
    return data;
  }
}

class AssistanceResultsModel extends ResultsModel {
  List<AssistanceModel>? results;

  AssistanceResultsModel({this.results});

  @override
  AssistanceResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <AssistanceModel>[];
      json['results'].forEach((v) {
        results!.add(AssistanceModel.fromJson(v));
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
