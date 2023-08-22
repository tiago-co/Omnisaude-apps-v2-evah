import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RatingFormModel {
  String? module;
  int? ratingValue;
  String? description;
  String? name;
  String? email;
  String? phone;
  bool acceptContact;
  RatingFormModel({
    this.module,
    this.ratingValue,
    this.description,
    this.name,
    this.email,
    this.phone,
    this.acceptContact = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'module': module,
      'ratingValue': ratingValue,
      'description': description,
      'name': name,
      'email': email,
      'phone': phone,
      'acceptContact': acceptContact,
    };
  }

  factory RatingFormModel.fromMap(Map<String, dynamic> map) {
    return RatingFormModel(
      module: map['module'] != null ? map['module'] as String : null,
      ratingValue:
          map['ratingValue'] != null ? map['ratingValue'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      acceptContact: map['acceptContact'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingFormModel.fromJson(String source) =>
      RatingFormModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
