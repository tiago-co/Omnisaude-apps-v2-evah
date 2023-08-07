import 'package:omni_general/omni_general.dart';

class RefundRequestQueryParamsModel extends QueryParamsModel {
  String? requestStatus;
  String? requestDate;
  String? requestNumber;

  RefundRequestQueryParamsModel({
    offset,
    limit,
    this.requestDate,
    this.requestNumber,
    this.requestStatus,
  }) : super(
          offset: offset,
          limit: limit,
        );

  RefundRequestQueryParamsModel.fromJson(Map<String, dynamic> json) {
    date = json['data'];
    startDate = json['data_inicio'];
    endDate = json['data_fim'];
    offset = json['offset'];
    limit = json['limit'];
    status = json['status'];
    type = json['tipo'];
    name = json['nome'];
    year = json['ano'];
    code = json['codigo'];
    requestStatus = json['ds_status_requisicao'];
    requestDate = json['dt_requisicao'];
    requestNumber = json['nr_seq_requisicao'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = date;
    data['data_inicio'] = startDate;
    data['data_fim'] = endDate;
    data['offset'] = offset;
    data['limit'] = limit;
    data['status'] = status;
    data['tipo'] = type;
    data['nome'] = name;
    data['ano'] = year;
    data['codigo'] = code;
    data['dt_requisicao'] = requestDate;
    data['ds_status_requisicao'] = requestStatus;
    data['nr_seq_requisicao'] = requestNumber;
    return data;
  }
}
