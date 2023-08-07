import 'package:dio/dio.dart';
import 'package:diseases/src/core/diseases_list_results_model.dart';
import 'package:diseases/src/modules/diseases/stores/diseases_list_store.dart';
import 'package:diseases/src/modules/diseases/widgets/disease_item_widget.dart';
import 'package:diseases_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class DiseasesListPage extends StatefulWidget {
  const DiseasesListPage({Key? key}) : super(key: key);

  @override
  State<DiseasesListPage> createState() => _DiseasesListPageState();
}

class _DiseasesListPageState extends State<DiseasesListPage> {
  final DiseasesListStore store = Modular.get();
  @override
  void initState() {
    store.getDiseasesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<DiseasesListStore, DioError, DiseasesListBaseResults>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return const LoadingWidget();
        }
        if (store.state.results!.isEmpty && !triple.isLoading) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const BouncingScrollPhysics(),
                    child: EmptyWidget(
                      message: DiseasesLabels.emptyList,
                      textButton: DiseasesLabels.tryAgain,
                      onPressed: () => store.getDiseasesList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        if (store.state.results!.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    shadowColor: Colors.transparent,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async => await store.getDiseasesList(),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: ((context, index) =>
                                  Divider(color: Theme.of(context).cardColor)),
                              shrinkWrap: true,
                              itemCount: store.state.results!.length,
                              itemBuilder: (_, index) {
                                return DiseaseItemWidget(
                                  typeTitle: DiseasesLabels.pathologyLabel,
                                  diseaseItem: store.state.results![index],
                                  assetPath: Assets.patologyIcon,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
