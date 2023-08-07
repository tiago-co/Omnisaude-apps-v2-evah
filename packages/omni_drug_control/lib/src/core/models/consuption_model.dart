import 'dart:convert';

class ConsuptionModel {
  bool? consumed;
  String? justification;
  bool? confirmMedicineConsupution;
  bool? confirmMedicineNotConsupution;
  ConsuptionModel({
    this.consumed,
    this.justification,
    this.confirmMedicineConsupution,
    this.confirmMedicineNotConsupution,
  });

  Map<String, dynamic> toMap() {
    return {
      'consumido': consumed,
      'justificativa': justification,
      'confirmar': confirmMedicineConsupution,
      'recusar': confirmMedicineNotConsupution
    };
  }

  factory ConsuptionModel.fromMap(Map<String, dynamic> map) {
    return ConsuptionModel(
      consumed: map['consumido'],
      justification: map['justificativa'],
      confirmMedicineConsupution: map['confirmar'],
      confirmMedicineNotConsupution: map['recusar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsuptionModel.fromJson(String source) =>
      ConsuptionModel.fromMap(json.decode(source));
}
