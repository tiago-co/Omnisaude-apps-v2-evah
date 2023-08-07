import 'package:omni_core/src/app/core/models/vaccine_category_model.dart';

class VaccineModel {
  String? id;
  String? name;
  VaccineCategoryModel? category;
  String? description;
  String? dose;
  String? lot;
  String? date;
  String? validate;
  String? laboraty;
  String? vaccination;
  String? professional;
  VaccineModel({
    this.id,
    this.name,
    this.category,
    this.description,
    this.dose,
    this.lot,
    this.date,
    this.validate,
    this.laboraty,
    this.vaccination,
    this.professional,
  });
}
