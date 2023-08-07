
class AppointmentModel {
  String? id;
  String? pep;
  String? medicalRecords;

  AppointmentModel({
    this.id,
    this.pep,
    this.medicalRecords,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pep = json['pep'];
    medicalRecords = json['prontuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pep'] = pep;
    data['prontuario'] = medicalRecords;
    return data;
  }
}
