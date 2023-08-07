class SchedulingParamsModel {
  String? professionalName;
  String? professionaType;
  String? ordering;
  String? specialty;
  String? startDate;
  String? endDate;
  String? status;
  String? limit;
  String? type;
  String? date;

  SchedulingParamsModel({
    this.professionalName,
    this.professionaType,
    this.ordering,
    this.specialty,
    this.startDate,
    this.endDate,
    this.status,
    this.limit,
    this.date,
    this.type,
  });

  SchedulingParamsModel.fromJson(Map<String, dynamic> json) {
    professionaType = json['tipo_profissional'];
    specialty = json['especialidade'];
    professionalName = json['nome'];
    startDate = json['data_inicio'];
    ordering = json['order-by-data-proxima'];
    endDate = json['data_fim'];
    status = json['status'];
    limit = json['limit'];
    date = json['data'];
    type = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tipo_profissional'] = professionaType;
    data['especialidade'] = specialty;
    data['nome'] = professionalName;
    data['order-by-data-proxima'] = ordering;
    data['data_inicio'] = startDate;
    data['data_fim'] = endDate;
    data['status'] = status;
    data['limit'] = limit;
    data['data'] = date;
    data['tipo'] = type;
    return data;
  }
}
