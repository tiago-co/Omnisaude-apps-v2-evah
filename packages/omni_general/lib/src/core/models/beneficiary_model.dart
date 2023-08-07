import 'package:omni_general/omni_general.dart';

class BeneficiaryModel {
  IndividualPersonModel? individualPerson;
  LecuponUserModel? lecuponUser;
  ProgramModel? programSelected;
  List<ProgramModel>? programs;
  String? status;
  bool? isPlanCardExpansive;

  BeneficiaryModel({
    this.individualPerson,
    this.lecuponUser,
    this.programSelected,
    this.programs,
    this.status,
    this.isPlanCardExpansive,
  });

  BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    individualPerson = json['pessoa_fisica'] != null
        ? IndividualPersonModel.fromJson(json['pessoa_fisica'])
        : null;
    programSelected = json['psp_selecionado'] != null
        ? ProgramModel.fromJson(json['psp_selecionado'])
        : null;
    if (json['psps'] != null) {
      programs = List<ProgramModel>.empty(growable: true);
      json['psps'].forEach((v) {
        programs?.add(ProgramModel.fromJson(v));
      });
    }
    lecuponUser = json['lecuponUser'] != null
        ? LecuponUserModel.fromJson(json['lecuponUser'])
        : null;
    status = json['status'];
    isPlanCardExpansive = json['isPlanCardExpansive'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pessoa_fisica'] = individualPerson?.toJson();
    data['lecuponUser'] = lecuponUser?.toJson();
    data['psp_selecionado'] = programSelected?.toJson();
    data['psps'] = programs?.map((v) => v.toJson()).toList();
    data['status'] = status;
    data['isPlanCardExpansive'] = isPlanCardExpansive ?? true;
    return data;
  }
}

class NewBeneficiaryModel {
  IndividualPersonModel? individualPerson;
  BeneficiaryResponsibleModel? responsible;
  String? nrRegistration;
  String? programCode;
  late bool termsAccepted;

  NewBeneficiaryModel({
    this.individualPerson,
    this.responsible,
    this.nrRegistration,
    this.programCode,
    this.termsAccepted = false,
  });

  NewBeneficiaryModel.fromJson(Map<String, dynamic> json) {
    individualPerson = json['pessoa_fisica'] != null
        ? IndividualPersonModel.fromJson(json['pessoa_fisica'])
        : null;
    responsible = json['responsavel'] != null
        ? BeneficiaryResponsibleModel.fromJson(json['responsavel'])
        : null;
    if (json['nr_matricula'] != null) {
      nrRegistration = json['nr_matricula'];
    }
    programCode = json['codigo_psp'];
    termsAccepted = json['termos_aceito'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pessoa_fisica'] = individualPerson?.toJson();
    data['responsavel'] = responsible?.toJson();
    data['nr_matricula'] = nrRegistration;
    data['codigo_psp'] = programCode;
    data['termos_aceito'] = termsAccepted;
    return data;
  }
}
