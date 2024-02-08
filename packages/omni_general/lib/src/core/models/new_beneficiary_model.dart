import 'package:omni_general/omni_general.dart';

class NewBeneficiaryModel {
  IndividualPersonModel? individualPerson;
  LecuponUserModel? lecuponUser;

  NewBeneficiaryModel({
    this.individualPerson,
    this.lecuponUser,
  });

  NewBeneficiaryModel.fromJson(Map<String, dynamic> json) {
    individualPerson = json['user'] != null ? IndividualPersonModel.fromJson(json['user']) : null;

    lecuponUser = json['lecuponUser'] != null ? LecuponUserModel.fromJson(json['lecuponUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = individualPerson?.toJson();
    data['lecuponUser'] = lecuponUser?.toJson();
    return data;
  }
}
