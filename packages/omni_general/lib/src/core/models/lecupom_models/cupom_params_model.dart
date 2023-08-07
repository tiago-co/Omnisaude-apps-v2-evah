class CupomParamsModel {
  String? lng;
  String? lat;
  String? organizationType;
  String? search;
  String? categoryId;
  String? page;
  int? organizationId;
  String? usageType;

  CupomParamsModel({
    this.lng,
    this.lat,
    this.organizationType,
    this.search,
    this.categoryId,
    this.page,
    this.organizationId,
    this.usageType,
  });

  CupomParamsModel.fromJson(Map<String, dynamic> json) {
    lng = json['lng'];
    lat = json['lat'];
    organizationType = json['organization_type'];
    search = json['search'];
    categoryId = json['category_id'];
    page = json['page'];
    organizationId = json['organization_id'];
    usageType = json['usage_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lng'] = lng;
    data['lat'] = lat;
    data['organization_type'] = organizationType;
    data['search'] = search;
    data['category_id'] = categoryId;
    data['page'] = page;
    data['organization_id'] = organizationId;
    data['usage_type'] = usageType;
    return data;
  }
}
