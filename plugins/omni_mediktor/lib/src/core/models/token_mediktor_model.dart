class TokenMediktorModel {
  bool? isSessionFinished;
  String? authToken;
  String? deviceId;
  String? externUserId;

  TokenMediktorModel({
    this.authToken,
    this.deviceId,
    this.externUserId,
    this.isSessionFinished = true,
  });

  TokenMediktorModel.fromJson(Map<String, dynamic> json) {
    authToken = json['authToken'];
    deviceId = json['deviceId'];
    externUserId = json['externUserId'];
    isSessionFinished = json['isSessionFinished'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authToken'] = authToken;
    data['deviceId'] = deviceId;
    data['externUserId'] = externUserId;
    data['isSessionFinished'] = isSessionFinished;
    return data;
  }
}
