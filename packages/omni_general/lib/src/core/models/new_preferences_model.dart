import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/new_beneficiary_model.dart';
import 'package:omni_general/src/core/models/new_jwt_model.dart';

class NewPreferencesModel {
  NewBeneficiaryModel? user;
  NewJwtModel? jwt;

  NewPreferencesModel({
    this.user,
    this.jwt,
  });

  NewPreferencesModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? NewBeneficiaryModel.fromJson(json['user']) : null;
    jwt = json['jwt'] != null ? NewJwtModel.fromJson(json['jwt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['jwt'] = jwt?.toJson();
    return data;
  }
}
