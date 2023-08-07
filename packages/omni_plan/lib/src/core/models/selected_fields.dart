class SelectedFieldsModel {
  String? selectedSpecialty;
  String? selectedAddress;
  bool? showPlaceholderSpecialty;
  bool? showPlaceholderAddress;
  bool? showCleanFavoriteFilter;

  SelectedFieldsModel({
    this.selectedAddress,
    this.selectedSpecialty,
    this.showPlaceholderAddress,
    this.showPlaceholderSpecialty,
    this.showCleanFavoriteFilter,
  });

  SelectedFieldsModel.fromJson(Map<String, dynamic> json) {
    selectedSpecialty = json['selected_specialty'];
    selectedAddress = json['selected_address'];
    showPlaceholderSpecialty = json['show_placeholder_specialty'];
    showPlaceholderAddress = json['show_placeholder_address'];
    showCleanFavoriteFilter = json['show_showCleanFavoriteFilter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selected_specialty'] = selectedSpecialty;
    data['selected_address'] = selectedAddress;
    data['show_placeholder_specialty'] = showPlaceholderSpecialty;
    data['show_placeholder_address'] = showPlaceholderAddress;
    data['show_placeholder_address'] = showPlaceholderAddress;
    data['show_showCleanFavoriteFilter'] = showCleanFavoriteFilter;
    return data;
  }
}
