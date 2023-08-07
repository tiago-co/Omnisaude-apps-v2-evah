import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:guide_providers_labels/labels.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_provider_model.dart';

import 'package:omni_plan/src/modules/guide_providers/stores/guide_providers_store.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/provider_item_shimmer_widget.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/provider_item_widget.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/providers_filters_widget.dart';

class GuideProvidersPage extends StatefulWidget {
  final String moduleName;

  const GuideProvidersPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _GuideProvidersPageState createState() => _GuideProvidersPageState();
}

class _GuideProvidersPageState extends State<GuideProvidersPage> {
  final GuideProvidersStore store = Modular.get();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    store.params.limit = '50';
    store.getPlanProviders(store.params);
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 50).toString();
        store.getPlanProviders(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.moduleName,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFieldWidget(
                  textInputAction: TextInputAction.search,
                  controller: searchController,
                  label: GuideProvidersLabels.guideProvidersSearch,
                  onChange: (String? input) {
                    if (input == null) return;
                    store.getProvidersByName(input, store.params);
                  },
                  placeholder: GuideProvidersLabels.guideProvidersInformProvider,
                  suffixIcon: const Icon(Icons.search_rounded),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: ProvidersFiltersWidget(),
              ),
              const Divider(height: 1),
              Expanded(
                child: _buildProvidersListWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildProvidersListWidget {
    return TripleBuilder<GuideProvidersStore, DioError,
        PlanProviderResultsModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading && triple.state.results.isEmpty) {
          return const ProviderItemShimmerWidget();
        } else {
          return triple.state.results.isNotEmpty
              ? RefreshIndicator(
                  displacement: 0,
                  strokeWidth: 0.75,
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () async {
                    store.getPlanProviders(store.params);
                  },
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: triple.state.results.length,
                    padding: const EdgeInsets.only(bottom: 30),
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    separatorBuilder: (_, index) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          ProviderItemWidget(
                            provider: triple.state.results[index],
                          ),
                          if (triple.isLoading &&
                              index == triple.state.results.length - 1)
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: LinearProgressIndicator(),
                            ),
                        ],
                      );
                    },
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const BouncingScrollPhysics(),
                          child: EmptyWidget(
                            message: GuideProvidersLabels.guideProvidersEmpty,
                            textButton: GuideProvidersLabels.tryAgain,
                            onPressed: () =>
                                store.getPlanProviders(store.params),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }
      },
    );
  }
}
