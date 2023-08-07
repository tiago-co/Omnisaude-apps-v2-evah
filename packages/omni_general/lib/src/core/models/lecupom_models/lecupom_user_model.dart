import 'package:omni_general/src/core/models/lecupom_models/business_model.dart';

class LecuponUserModel {
  int? id;
  String? name;
  String? cellphone;
  String? taxpayerNumber;
  String? email;
  bool? facebook;
  bool? premium;
  bool? profileComplete;
  Business? business;
  String? fullAddress;
  String? lat;
  String? lng;
  String? client;
  String? accessToken;

  LecuponUserModel({
    this.id,
    this.name,
    this.cellphone,
    this.taxpayerNumber,
    this.email,
    this.facebook,
    this.premium,
    this.profileComplete,
    this.business,
    this.fullAddress,
    this.lat,
    this.lng,
  });

  LecuponUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cellphone = json['cellphone'];
    taxpayerNumber = json['taxpayer_number'];
    email = json['email'];
    facebook = json['facebook'];
    premium = json['premium'];
    profileComplete = json['profile_complete'];
    business =
        json['business'] != null ? Business.fromJson(json['business']) : null;
    fullAddress = json['full_address'];
    lat = json['lat'] ?? '';
    lng = json['lng'] ?? '';
    accessToken = json['access_token'] ?? '';
    client = json['client'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cellphone'] = cellphone;
    data['taxpayer_number'] = taxpayerNumber;
    data['email'] = email;
    data['facebook'] = facebook;
    data['premium'] = premium;
    data['profile_complete'] = profileComplete;
    if (business != null) {
      data['business'] = business!.toJson();
    }
    data['full_address'] = fullAddress;
    data['lat'] = lat;
    data['lng'] = lng;
    data['access_token'] = accessToken;
    data['client'] = client;
    return data;
  }
}
