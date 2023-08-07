class AssistanceQueryParamsModel {
  String? subject;
  String? offset;
  String? limit;
  String? type;
  String? status;

  AssistanceQueryParamsModel({
    this.offset,
    this.limit,
    this.subject,
    this.status,
    this.type,
  });

  AssistanceQueryParamsModel.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    subject = json['assunto'];
    limit = json['limit'];
    status = json['status'];
    type = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['limit'] = limit;
    data['assunto'] = subject;
    data['status'] = status;
    data['tipo'] = type;
    return data;
  }
}
