import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:guide_providers_labels/labels.dart';
import 'package:omni_plan/src/core/models/selected_fields.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/filters_store.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/guide_providers_store.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/selected_filter.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/providers_filter_buttom.dart';

class ProvidersFiltersWidget extends StatefulWidget {
  const ProvidersFiltersWidget({Key? key}) : super(key: key);

  @override
  _ProvidersFiltersWidgetState createState() => _ProvidersFiltersWidgetState();
}

class _ProvidersFiltersWidgetState extends State<ProvidersFiltersWidget> {
  final FiltersStore filtersStore = Modular.get();
  final SelectedFilterStore selectedFilterStore = Modular.get();
  final GuideProvidersStore guideProvidersStore =
      Modular.get<GuideProvidersStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: TripleBuilder<SelectedFilterStore, Exception, SelectedFieldsModel>(
        store: selectedFilterStore,
        builder: (_, triple) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: <Widget>[
                ProvidersFilterButtom(
                  showClose: triple.state.showCleanFavoriteFilter ?? false,
                  errorText: GuideProvidersLabels.providersFiltersErrorFavorite,
                  searchText:
                      GuideProvidersLabels.providersFiltersSearchFavorite,
                  placeholder:
                      GuideProvidersLabels.providersFiltersPlaceholderFavorite,
                  name: GuideProvidersLabels.providersFiltersNameFavorite,
                  onClose: () {
                    guideProvidersStore.params.favorites = null;
                    selectedFilterStore.updateFavoriteFilter(
                      guideProvidersStore.params.favorites ?? false,
                    );
                    guideProvidersStore.getPlanProviders(
                      guideProvidersStore.params,
                    );
                  },
                  modalItemOnTap: () {
                    guideProvidersStore.params.favorites = true;
                    selectedFilterStore.updateFavoriteFilter(
                      guideProvidersStore.params.favorites!,
                    );
                    guideProvidersStore.getPlanProviders(
                      guideProvidersStore.params,
                    );
                  },
                ),
                const SizedBox(width: 15),
                ProvidersFilterButtom(
                  showClose: triple.state.showPlaceholderSpecialty!,
                  errorText:
                      GuideProvidersLabels.providersFiltersErrorSpecialty,
                  searchText:
                      GuideProvidersLabels.providersFiltersSearchSpecialty,
                  placeholder:
                      GuideProvidersLabels.providersFiltersPlaceholderSpecialty,
                  name: triple.state.selectedSpecialty!,
                  onClose: () {
                    selectedFilterStore
                        .updateSelectedSpecialty('Especialidede');
                    guideProvidersStore.getProvidersBySpecialty(
                      '',
                      guideProvidersStore.params,
                    );
                  },
                  modalItemOnTap: (itemName) {
                    selectedFilterStore.updateSelectedSpecialty(itemName);
                    guideProvidersStore.getProvidersBySpecialty(
                      itemName,
                      guideProvidersStore.params,
                    );
                  },
                  initialSateOnTap: filtersStore.getProviderSpecialties,
                ),
                const SizedBox(width: 15),
                ProvidersFilterButtom(
                  onClose: () {
                    selectedFilterStore.updateSelectedAddress('Localidade');
                    guideProvidersStore.getProvidersByAddress(
                      '',
                      guideProvidersStore.params,
                    );
                  },
                  showClose: triple.state.showPlaceholderAddress!,
                  errorText: GuideProvidersLabels.providersFiltersErrorLocation,
                  searchText:
                      GuideProvidersLabels.providersFiltersSearchLocation,
                  placeholder:
                      GuideProvidersLabels.providersFiltersPlaceholderLocation,
                  name: triple.state.selectedAddress!,
                  initialSateOnTap: filtersStore.getProviderAddress,
                  modalItemOnTap: (itemName) {
                    selectedFilterStore.updateSelectedAddress(itemName);
                    guideProvidersStore.getProvidersByAddress(
                      itemName,
                      guideProvidersStore.params,
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
