class OrganizationModel {
  int? id;
  String? name;
  String? coverPicture;
  String? backgroundPicture;
  num? bestDiscountPercent;
  String? categoryName;
  String? instagramUrl;
  String? facebooKUrl;
  String? twitterUrl;
  num? cashbackPercent;
  String? cashbackText;
  String? discountText;
  String? description;
  bool? favorited;
  String? shortDescription;
  num? distanceKm;

  OrganizationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverPicture = json['cover_picture'];
    backgroundPicture = json['background_picture'];
    bestDiscountPercent = json['best_discount_percent'];
    categoryName = json['category_name'];
    instagramUrl = json['instagram_url'];
    facebooKUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    cashbackPercent = json['cashback_percent'];
    cashbackText = json['cashback_text'];
    description = json['discount_text'];
    discountText = json['description'];
    favorited = json['favorited'];
    shortDescription = json['short_description'];
    distanceKm = json['distance_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover_picture'] = coverPicture;
    data['background_picture'] = backgroundPicture;
    data['best_discount_percent'] = bestDiscountPercent;
    data['category_name'] = categoryName;
    data['instagram_url'] = instagramUrl;
    data['facebook_url'] = facebooKUrl;
    data['twitter_url'] = twitterUrl;
    data['cashback_percent'] = cashbackPercent;
    data['cashback_text'] = cashbackText;
    data['discount_text'] = discountText;
    data['description'] = description;
    data['favorited'] = favorited;
    data['short_description'] = shortDescription;
    data['distance_km'] = distanceKm;
    return data;
  }
}
