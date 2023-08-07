class CaregiverNotificationsModel {
  bool? sendSMS;
  bool? sendEmail;

  CaregiverNotificationsModel({
    this.sendEmail,
    this.sendSMS,
  });

  CaregiverNotificationsModel.fromJson(Map<String, dynamic> json) {
    sendSMS = json['envio_sms'];
    sendEmail = json['envio_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['envio_sms'] = sendSMS;
    data['envio_email'] = sendEmail;
    return data;
  }
}
