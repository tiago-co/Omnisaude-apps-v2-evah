import 'dart:convert';

class SessionConclusionObject {
  final String? description;
  final String? icd9;
  final String? icd10;
  final List<String>? specialties;
  final List<String>? specialtiesId;
  final int? percentage;
  SessionConclusionObject({
    this.description,
    this.icd9,
    this.icd10,
    this.specialties,
    this.specialtiesId,
    this.percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'icd9': icd9,
      'icd10': icd10,
      'specialties': specialties,
      'specialtiesId': specialtiesId,
      'percentage': percentage,
    };
  }

  factory SessionConclusionObject.fromMap(Map<String, dynamic> map) {
    return SessionConclusionObject(
      description: map['description'],
      icd9: map['icd9'],
      icd10: map['icd10'],
      specialties: List<String>.from(map['specialties']),
      specialtiesId: List<String>.from(map['specialtyIdList']),
      percentage: map['percentage']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionConclusionObject.fromJson(String source) =>
      SessionConclusionObject.fromMap(json.decode(source));
}
