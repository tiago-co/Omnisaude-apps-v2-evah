import 'package:omni_caregiver/omni_caregiver.dart' show CaregiverModel;
import 'package:omni_drug_control/src/core/enums/drug_control_enum.dart';
import 'package:omni_general/omni_general.dart';

class DrugControlModel {
  String? id;
  String? dosage;
  String? unity;
  String? interval;
  String? administration;
  late bool continuousUse;
  DrugControlType? type;
  String? description;
  String? startDate;
  String? endDate;
  String? startHour;
  String? medicine;
  late List<CaregiverModel> caregivers;

  DrugControlModel({
    this.id,
    this.dosage,
    this.unity,
    this.interval,
    this.administration,
    this.continuousUse = false,
    this.type = DrugControlType.secondary,
    this.description,
    this.startDate,
    this.endDate,
    this.startHour,
    this.medicine,
    this.caregivers = const [],
  });

  DrugControlModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dosage = json['dose'];
    unity = json['unidade'];
    interval = json['aprazamento'];
    administration = json['via_administracao'];
    continuousUse = json['uso_continuo'] ?? false;
    type = drugControlTypeFromJson(json['tipo']);
    description = json['observacao'];
    startDate = json['data_inicio'];
    endDate = json['data_fim'];
    startHour = json['hora_inicio'];
    medicine = json['medicamento'];
    if (json['cuidadores'] != null) {
      caregivers = List<CaregiverModel>.empty(growable: true);
      json['cuidadores'].forEach((v) {
        caregivers.add(CaregiverModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dose'] = dosage;
    data['unidade'] = unity;
    data['aprazamento'] = interval;
    data['via_administracao'] = administration;
    data['uso_continuo'] = continuousUse;
    data['tipo'] = type?.toJson;
    data['observacao'] = description;
    data['data_inicio'] = startDate;
    data['data_fim'] = endDate;
    data['hora_inicio'] = startHour;
    data['medicamento'] = medicine;
    data['cuidadores'] = caregivers.map((v) => v.toJson()).toList();
    return data;
  }
}

class DrugControlResultsModel extends ResultsModel {
  List<DrugControlModel>? results;

  DrugControlResultsModel({this.results});

  DrugControlResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<DrugControlModel>.empty(growable: true);
      json['results'].forEach(
        (v) => results!.add(DrugControlModel.fromJson(v)),
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
