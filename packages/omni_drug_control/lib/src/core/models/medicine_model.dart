import 'package:omni_drug_control/src/core/enums/medicine_status_enum.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_general/omni_general.dart' show ResultsModel;

class MedicineModel {
  String? id;
  DrugControlModel? medicamento;
  String? criadoEm;
  String? modificadoEm;
  String? deletadoEm;
  String? dataUso;
  String? dataRegistro;
  MedicineStatusTypeEnum? status;
  bool? consumido;
  bool? notificado;
  String? justificativa;

  MedicineModel({
    this.id,
    this.medicamento,
    this.criadoEm,
    this.modificadoEm,
    this.deletadoEm,
    this.dataUso,
    this.dataRegistro,
    this.status,
    this.consumido,
    this.notificado,
    this.justificativa,
  });

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicamento = json['medicamento'] != null
        ? DrugControlModel.fromJson(json['medicamento'])
        : null;
    criadoEm = json['criado_em'];
    modificadoEm = json['modificado_em'];
    deletadoEm = json['deletado_em'];
    dataUso = json['data_uso'];
    dataRegistro = json['data_registro'];
    status = medicineStatusTypeEnumFromJson(json['status']);
    consumido = json['consumido'];
    notificado = json['notificado'];
    justificativa = json['justificativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicamento'] = medicamento?.toJson();
    data['criado_em'] = criadoEm;
    data['modificado_em'] = modificadoEm;
    data['deletado_em'] = deletadoEm;
    data['data_uso'] = dataUso;
    data['data_registro'] = dataRegistro;
    data['status'] = status!.toJson;
    data['consumido'] = consumido;
    data['notificado'] = notificado;
    data['justificativa'] = justificativa;
    return data;
  }
}

class MedicineResultsModel extends ResultsModel {
  List<MedicineModel>? results;

  MedicineResultsModel({this.results});

  MedicineResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<MedicineModel>.empty(growable: true);
      json['results'].forEach(
        (v) => results!.add(MedicineModel.fromJson(v)),
      );
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
