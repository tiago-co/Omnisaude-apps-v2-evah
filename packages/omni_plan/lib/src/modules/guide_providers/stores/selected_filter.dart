import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/selected_fields.dart';

class SelectedFilterStore
    extends NotifierStore<Exception, SelectedFieldsModel> {
  SelectedFilterStore()
      : super(
          SelectedFieldsModel(
            selectedAddress: 'Localidade',
            selectedSpecialty: 'Especialidade',
            showPlaceholderAddress: false,
            showPlaceholderSpecialty: false,
          ),
        );
  void updateSelectedAddress(String address) {
    if (address != 'Localidade') {
      state.showPlaceholderAddress = true;
    } else {
      state.showPlaceholderAddress = false;
    }
    state.selectedAddress = address;
    update(SelectedFieldsModel.fromJson(state.toJson()));
  }

  void updateSelectedSpecialty(String specialty) {
    if (specialty != 'Especialidede') {
      state.showPlaceholderSpecialty = true;
    } else {
      state.showPlaceholderSpecialty = false;
    }
    state.selectedSpecialty = specialty;
    update(SelectedFieldsModel.fromJson(state.toJson()));
  }

  void updateFavoriteFilter(bool showLabel) {
    state.showCleanFavoriteFilter = showLabel;
    update(SelectedFieldsModel.fromJson(state.toJson()));
  }
}
