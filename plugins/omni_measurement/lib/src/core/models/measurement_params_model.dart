class MeasurementParamsModel {
  String? startDate;
  String? endDate;
  String? limit;
  String? type;
  String? date;

  MeasurementParamsModel({
    this.startDate,
    this.endDate,
    this.limit,
    this.date,
    this.type,
  });

  MeasurementParamsModel.fromJson(Map<String, dynamic> json) {
    startDate = json['data_inicio'];
    endDate = json['data_fim'];
    limit = json['limit'];
    date = json['data'];
    type = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_inicio'] = startDate;
    data['data_fim'] = endDate;
    data['limit'] = limit;
    data['data'] = date;
    data['tipo'] = type;
    return data;
  }
}
