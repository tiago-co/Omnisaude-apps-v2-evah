class MediktorMeasurementTypeModel {
  List<String>? tiposMedicao;

  MediktorMeasurementTypeModel({this.tiposMedicao});

  MediktorMeasurementTypeModel.fromJson(Map<String, dynamic> json) {
    tiposMedicao = json['dispositivos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dispositivos'] = tiposMedicao;
    return data;
  }
}
