class SmartLinkTokenModel {
  String? webSmartLink;
  String? appSmartLink;
  String? smartToken;

  SmartLinkTokenModel({this.webSmartLink, this.appSmartLink, this.smartToken});

  SmartLinkTokenModel.fromJson(Map<String, dynamic> json) {
    webSmartLink = json['web_smart_link'];
    appSmartLink = json['app_smart_link'];
    smartToken = json['smart_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['web_smart_link'] = webSmartLink;
    data['app_smart_link'] = appSmartLink;
    data['smart_token'] = smartToken;
    return data;
  }
}
