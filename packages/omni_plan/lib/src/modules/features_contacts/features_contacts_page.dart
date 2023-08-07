import 'package:dio/dio.dart';
import 'package:features_contacts_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

import 'package:omni_plan/src/modules/features_contacts/features_contacts_store.dart';

class FeaturesContactsPage extends StatefulWidget {
  final String moduleName;

  const FeaturesContactsPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _FeaturesContactsStatePage createState() => _FeaturesContactsStatePage();
}

class _FeaturesContactsStatePage extends State<FeaturesContactsPage> {
  final FeaturesContactsStore store = Modular.get();
  @override
  void initState() {
    store.getPlanFeaturesContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.moduleName,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Theme(
          data: Theme.of(context).copyWith(
            shadowColor: Colors.transparent,
          ),
          child: TripleBuilder<FeaturesContactsStore, DioError, int>(
            store: store,
            builder: (_, triple) {
              if (!triple.isLoading && triple.error != null) {
                if (triple.error!.response!.statusCode == 404) {
                  return Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      physics: const BouncingScrollPhysics(),
                      child: EmptyWidget(
                        message: FeaturesContactsLabels.featuresContactsEmpty,
                        textButton: FeaturesContactsLabels.tryagain,
                        onPressed: () => store.getPlanFeaturesContacts(),
                      ),
                    ),
                  );
                }
                return Center(
                  child: RequestErrorWidget(
                    error: triple.error,
                    onPressed: () => store.getPlanFeaturesContacts(),
                  ),
                );
              }
              return RefreshIndicator(
                displacement: 0,
                strokeWidth: 0.75,
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).colorScheme.background,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () async {
                  store.getPlanFeaturesContacts();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: _buildFormWidget(triple),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFormWidget(Triple triple) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsEnrollment,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsName,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsEstablishment,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsProduct,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsCoverage,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsStipulating,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsValidity,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsNumber,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
        RowTextFieldWidget(
          label: FeaturesContactsLabels.featuresContactsUpdate,
          value: triple.state.toString(),
          isLoading: triple.isLoading,
        ),
      ],
    );
  }
}
