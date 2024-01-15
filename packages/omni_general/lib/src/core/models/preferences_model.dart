import 'package:omni_general/omni_general.dart';

class PreferencesModel {
  BeneficiaryModel? beneficiary;
  JwtModel? jwt;
  int? primaryColor;
  OperatorConfigsModel? oprConfigs;
  RenderViewType? renderViewType;
  PairedDevicesModel? pairedDevices;

  PreferencesModel({
    this.beneficiary,
    this.jwt,
    this.primaryColor,
    this.oprConfigs,
    this.renderViewType,
    this.pairedDevices,
  });

  PreferencesModel.fromJson(Map<String, dynamic> json) {
    beneficiary = json['beneficiary'] != null ? BeneficiaryModel.fromJson(json['beneficiary']) : null;
    jwt = json['jwt'] != null ? JwtModel.fromJson(json['jwt']) : null;
    primaryColor = json['primaryColor'];
    oprConfigs = json['globalConfigs'] != null ? OperatorConfigsModel.fromJson(json['globalConfigs']) : null;
    renderViewType = renderViewTypeFromJson(json['renderViewType']);
    pairedDevices = json['pairedDevices'] != null
        ? PairedDevicesModel.fromJson(json['pairedDevices'])
        : PairedDevicesModel(
            accuCheckGuideList: [],
            nonin3230List: [],
            td3128List: [],
            td8255List: [],
          );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beneficiary'] = beneficiary?.toJson();
    data['jwt'] = jwt?.toJson();
    data['primaryColor'] = primaryColor;
    data['renderViewType'] = renderViewType?.toJson;
    data['globalConfigs'] = oprConfigs?.toJson();
    data['pairedDevices'] = pairedDevices?.toJson();
    return data;
  }
}
