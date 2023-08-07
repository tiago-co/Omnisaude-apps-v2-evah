import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_status_enum.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_type_enum.dart';
import 'package:omni_scheduling/src/core/models/appointment_model.dart';
import 'package:omni_scheduling/src/core/models/hilab_exams_model.dart';
import 'package:omni_scheduling/src/core/models/medical_certificate_model.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/core/models/specialty_model.dart';

class NewSchedulingModel {
  String? id;
  String? beneficiaryId;
  String? professionalId;
  SchedulingType? schedulingType;
  String? reason;
  String? date;
  String? category;
  String? specialty;
  String? hour;
  bool? mediktor;

  NewSchedulingModel({
    this.id,
    this.beneficiaryId,
    this.professionalId,
    this.schedulingType,
    this.reason,
    this.date,
    this.specialty,
    this.category,
    this.hour,
    this.mediktor,
  });

  NewSchedulingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beneficiaryId = json['beneficiario_id'];
    professionalId = json['profissional_saude_id'];
    schedulingType = schedulingTypeFromJson(json['tipo_atendimento']);
    reason = json['motivo'];
    date = json['data_inicio'];
    mediktor = json['mediktor'];

    category = json['category'];
    specialty = json['specialty'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['beneficiario_id'] = beneficiaryId;
    data['profissional_saude_id'] = professionalId;
    data['tipo_atendimento'] = schedulingType?.toJson;
    data['motivo'] = reason;
    data['data_inicio'] = date;
    data['mediktor'] = mediktor;

    data['category'] = category;
    data['specialty'] = specialty;
    data['hour'] = hour;
    return data;
  }
}

class SchedulingModel {
  String? id;
  String? oldId;
  String? reason;
  String? createdBy;
  String? startDate;
  SchedulingType? type;
  String? cancelReason;
  String? reschedulingBy;
  String? reschedulingAt;
  String? peerBeneficiary;
  String? peerProfessional;
  bool? medicalPrescription;
  bool? haveHilabExams;
  SchedulingStatus? status;
  SpecialtyModel? specialty;
  AppointmentModel? appointment;
  SchedulingModel? oldScheduling;
  ProfessionalModel? professional;
  MedicalCertificateModel? medicalCertificate;
  List<HilabExamsModel>? hilabExams;

  SchedulingModel({
    this.id,
    this.oldId,
    this.status,
    this.startDate,
    this.type,
    this.cancelReason,
    this.professional,
    this.specialty,
    this.peerProfessional,
    this.peerBeneficiary,
    this.reason,
    this.appointment,
    this.medicalCertificate,
    this.medicalPrescription,
    this.createdBy,
    this.reschedulingBy,
    this.reschedulingAt,
    this.haveHilabExams,
    this.hilabExams,
  });

  SchedulingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldId = json['oldId'];
    if (json['profissional_saude'] != null) {
      professional = ProfessionalModel.fromJson(json['profissional_saude']);
    } else {
      professional = null;
    }

    if (json['status'] != null) {
      status = schedulingStatusFromJson(json['status']);
    }

    if (json['data_inicio'] != null) {
      final String dataInicio = json['data_inicio'];
      final String dataSemUTC = dataInicio.substring(0, dataInicio.length - 6);
      startDate = dataSemUTC;
    }
    type = schedulingTypeFromJson(json['tipo_atendimento']);

    if (json['razao_cancelamento'] != null) {
      cancelReason = json['razao_cancelamento'];
    }
    if (json['agendamento_antigo'] != null) {
      oldScheduling = SchedulingModel.fromJson(json['agendamento_antigo']);
    } else {
      oldScheduling = null;
    }
    if (json['especialidade'] != null) {
      specialty = SpecialtyModel.fromJson(json['especialidade']);
    } else {
      specialty = null;
    }
    if (json['peer_profissional_saude'] != null) {
      peerProfessional = json['peer_profissional_saude'];
    }
    if (json['peer_beneficiario'] != null) {
      peerBeneficiary = json['peer_beneficiario'];
    }
    if (json['motivo'] != null) {
      reason = json['motivo'];
    }
    if (json['consulta'] != null) {
      appointment = AppointmentModel.fromJson(json['consulta']);
    } else {
      appointment = null;
    }
    if (json['atestado'] != null) {
      medicalCertificate = MedicalCertificateModel.fromJson(json['atestado']);
    } else {
      medicalCertificate = null;
    }
    if (json['exames_hilab'] != null) {
      hilabExams = List<HilabExamsModel>.empty(growable: true);
      json['exames_hilab'].forEach((exam) {
        hilabExams!.add(HilabExamsModel.fromJson(exam));
      });
    } else {
      hilabExams = null;
    }
    if (json['prescricao_memed'] != null) {
      medicalPrescription = json['prescricao_memed'];
    }
    if (json['possui_exames_hilab'] != null) {
      haveHilabExams = json['possui_exames_hilab'];
    }
    if (json['criado_por'] != null) {
      createdBy = json['criado_por'];
    }
    if (json['reagendado_por'] != null) {
      reschedulingBy = json['reagendado_por'];
    }
    if (json['reagendado_em'] != null) {
      reschedulingAt = json['reagendado_em'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['oldId'] = oldId;
    data['profissional_saude'] = professional?.toJson();
    data['status'] = status?.toJson;
    data['data_inicio'] = startDate;
    data['tipo_atendimento'] = type?.toJson;
    data['razao_cancelamento'] = cancelReason;
    data['agendamento_antigo'] = oldScheduling?.toJson();
    data['especialidade'] = specialty?.toJson();
    data['peer_profissional_saude'] = peerProfessional;
    data['peer_beneficiario'] = peerBeneficiary;
    data['motivo'] = reason;
    data['consulta'] = appointment?.toJson();
    data['atestado'] = medicalCertificate?.toJson();
    data['prescricao_memed'] = medicalPrescription;
    data['criado_por'] = createdBy;
    data['reagendado_por'] = reschedulingBy;
    data['reagendado_em'] = reschedulingAt;
    return data;
  }
}

class SchedulingResultsModel extends ResultsModel {
  late List<SchedulingModel> results;

  SchedulingResultsModel({this.results = const []});

  SchedulingResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<SchedulingModel>.empty(growable: true);
      json['results'].forEach((v) => results.add(SchedulingModel.fromJson(v)));
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
