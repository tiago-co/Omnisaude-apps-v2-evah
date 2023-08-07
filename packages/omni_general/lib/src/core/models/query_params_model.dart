class QueryParamsModel {
  String? date;
  String? startDate;
  String? endDate;
  String? name;
  String? offset;
  String? limit;
  String? type;
  String? status;
  String? year;
  String? code;

  QueryParamsModel({
    this.date,
    this.startDate,
    this.endDate,
    this.offset,
    this.limit,
    this.status,
    this.type,
    this.name,
    this.year,
    this.code,
  });

  QueryParamsModel.fromJson(Map<String, dynamic> json) {
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
  }

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
    return data;
  }
}
