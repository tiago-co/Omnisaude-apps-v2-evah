import 'package:omni_core/omni_core.dart';
import 'package:omni_general/src/core/models/lecupom_models/working_day_model.dart';

class CupomModel {
  int? id;
  String? organizationName;
  String? organizationCoverImage;
  CouponTemplateType? template;
  String? title;
  String? description;
  String? cashbackText;
  String? onlinePaymentText;
  num? discount;
  String? startDate;
  String? endDate;
  bool? infinity;
  String? pictureSmallUrl;
  String? pictureLargeUrl;
  int? organizationId;
  num? branchId;
  String? rules;
  String? code;
  String? activationUrl;
  List<WorkingDayModel>? workingDays;
  String? usageType;

  CupomModel({
    this.id,
    this.template,
    this.title,
    this.description,
    this.cashbackText,
    this.onlinePaymentText,
    this.discount,
    this.startDate,
    this.endDate,
    this.infinity,
    this.pictureSmallUrl,
    this.pictureLargeUrl,
    this.organizationId,
    this.branchId,
    this.organizationCoverImage,
    this.organizationName,
    this.rules,
    this.workingDays,
    this.code,
    this.activationUrl,
    this.usageType,
  });

  CupomModel.fromJson(Map<String, dynamic> json) {
    workingDays = List.empty(growable: true);
    id = json['id'];
    title = json['title'];
    description = json['description'];
    cashbackText = json['cashback_text'];
    onlinePaymentText = json['online_playment_text'];
    discount = json['discount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    infinity = json['infinity'];
    pictureSmallUrl = json['picture_small_url'];
    pictureLargeUrl = json['picture_large_url'];
    branchId = json['branch_id'];
    organizationCoverImage = json['organization_cover_image'];
    organizationId = json['organization_id'];
    organizationName = json['organization_name'];
    rules = json['rules'];
    code = json['code'];
    activationUrl = json['activation_url'];
    if (json['working_days'] != null) {
      json['working_days'].forEach((element) {
        workingDays?.add(WorkingDayModel.fromJson(element));
      });
    }
    template = couponTemplateTypeFromJson(json['template'], json['code']);
    usageType = json['usage_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['template'] = template;
    data['title'] = title;
    data['description'] = description;
    data['cashback_text'] = cashbackText;
    data['online_playment_text'] = onlinePaymentText;
    data['discount'] = discount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['infinity'] = infinity;
    data['picture_small_url'] = pictureSmallUrl;
    data['picture_large_url'] = pictureLargeUrl;
    data['organization_id'] = organizationId;
    data['branch_id'] = branchId;
    data['organization_cover_image'] = organizationCoverImage;
    data['organization_name'] = organizationName;
    data['rules'] = rules;
    data['code'] = code;
    data['activation_url'] = activationUrl;
    data['usage_type'] = usageType;
    return data;
  }
}
