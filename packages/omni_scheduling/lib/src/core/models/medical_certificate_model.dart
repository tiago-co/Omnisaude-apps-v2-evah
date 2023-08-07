class MedicalCertificateModel {
  String? id;
  String? code;
  int? value;
  String? unity;
  String? createdAt;
  String? modifiedAt;
  String? appointment;

  MedicalCertificateModel({
    this.id,
    this.code,
    this.value,
    this.unity,
    this.createdAt,
    this.modifiedAt,
    this.appointment,
  });

  MedicalCertificateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['codigo'];
    appointment = json['consulta'];
    value = json['valor'];
    unity = json['unidade'];
    createdAt = json['criado_em'];
    modifiedAt = json['modificado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['codigo'] = code;
    data['consulta'] = appointment;
    data['valor'] = value;
    data['unidade'] = unity;
    data['criado_em'] = createdAt;
    data['modificado_em'] = modifiedAt;
    return data;
  }
}
