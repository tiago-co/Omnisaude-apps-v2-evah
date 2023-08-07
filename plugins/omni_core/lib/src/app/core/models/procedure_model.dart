import 'package:omni_core/src/app/core/enums/procedure_enum.dart';
import 'package:omni_general/omni_general.dart' show ResultsModel;

class ProcedureModel {
  String? id;
  String? date;
  ProcedureType? type;
  String? observation;
  String? reason;
  ProcedureStatus? status;
  String? name;
  String? doctorName;
  String? doctorEmail;
  String? address;
  String? number;
  String? zipCode;
  String? uf;
  String? city;
  String? nurseName;
  String? nurseEmail;
  String? cr;
  String? ufCr;
  String? hospitalName;
  String? reasonCancel;

  ProcedureModel({
    this.id,
    this.date,
    this.type,
    this.observation,
    this.reason,
    this.status,
    this.name,
    this.doctorName,
    this.doctorEmail,
    this.address,
    this.number,
    this.zipCode,
    this.uf,
    this.city,
    this.nurseName,
    this.nurseEmail,
    this.cr,
    this.ufCr,
    this.hospitalName,
    this.reasonCancel,
  });

  ProcedureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['data'];
    type = procedureTypeFromJson(json['tipo']);
    observation = json['observacao'];
    reason = json['motivo'];
    status = procedureStatusFromJson(json['status']);
    name = json['nome'];
    doctorName = json['nome_medico'];
    doctorEmail = json['email_medico'];
    address = json['logradouro'];
    number = json['numero'];
    zipCode = json['cep'];
    uf = json['uf'];
    city = json['cidade'];
    nurseName = json['nome_enfermeiro'];
    nurseEmail = json['email_enfermeiro'];
    cr = json['cr'];
    ufCr = json['uf_cr'];
    hospitalName = json['nome_hospital'];
    reasonCancel = json['motivo_cancelamento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['data'] = date;
    data['tipo'] = type?.toJson;
    data['observacao'] = observation;
    data['motivo'] = reason;
    data['status'] = status?.toJson;
    data['nome'] = name;
    data['nome_medico'] = doctorName;
    data['email_medico'] = doctorEmail;
    data['logradouro'] = address;
    data['numero'] = number;
    data['cep'] = zipCode;
    data['uf'] = uf;
    data['cidade'] = city;
    data['nome_enfermeiro'] = nurseName;
    data['email_enfermeiro'] = nurseEmail;
    data['cr'] = cr;
    data['uf_cr'] = ufCr;
    data['nome_hospital'] = hospitalName;
    data['motivo_cancelamento'] = reasonCancel;
    return data;
  }
}

class ProcedureResultsModel extends ResultsModel {
  late final List<ProcedureModel> results;

  ProcedureResultsModel({this.results = const []});

  @override
  ProcedureResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ProcedureModel>[];
      json['results'].forEach((v) {
        results.add(ProcedureModel.fromJson(v));
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
    data['results'] = results.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
