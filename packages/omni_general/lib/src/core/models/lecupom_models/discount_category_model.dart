import 'dart:convert';

class DiscountCategoryModel {
  int? id;
  String? title;
  String? icon;
  String? categoryType;

  DiscountCategoryModel({
    this.id,
    this.title,
    this.icon,
    this.categoryType,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (icon != null) {
      result.addAll({'icon': icon});
    }
    if (categoryType != null) {
      result.addAll({'category_type': categoryType});
    }

    return result;
  }

  factory DiscountCategoryModel.fromMap(Map<String, dynamic> map) {
    return DiscountCategoryModel(
      id: map['id']?.toInt(),
      title: map['title'],
      icon: map['icon'],
      categoryType: map['category_type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscountCategoryModel.fromJson(String source) =>
      DiscountCategoryModel.fromMap(json.decode(source));
}
