import 'package:dio/dio.dart';
import 'package:extra_data_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/extra_data_historic_page.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_store.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/widgets/extra_data_type_filter_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_widget.dart';
import 'package:omni_general/omni_general.dart';

class ExtraDataPage extends StatefulWidget {
  final String moduleName;
  const ExtraDataPage({Key? key, required this.moduleName}) : super(key: key);

  @override
  _ExtraDataPageState createState() => _ExtraDataPageState();
}

class _ExtraDataPageState extends State<ExtraDataPage> {
  final ExtraDataStore store = Modular.get();
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  @override
  void initState() {
    store.params.limit = '10';
    store.getExtraData(store.params);
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getExtraData(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    store.historicStore.destroy();
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ExtraDataTypeFilterWidget(pageController: pageController),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFieldWidget(
                          label: ExtraDataLabels.extraDataSearchLabel,
                          placeholder:
                              ExtraDataLabels.extraDataSearchPlaceholder,
                          controller: TextEditingController(),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            shadowColor: Colors.transparent,
                          ),
                          child: RefreshIndicator(
                            displacement: 0,
                            strokeWidth: 0.75,
                            color: Theme.of(context).primaryColor,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                            onRefresh: () async {
                              store.getExtraData(store.params);
                            },
                            child: _buildExtraDataListWidget,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const ExtraDataHistoricPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildExtraDataListWidget {
    return TripleBuilder<ExtraDataStore, DioError, DynamicFormResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();

        if (triple.isLoading) {
          loading = const DynamicFormShimmerWidget();
        }
        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () {
                        store.getExtraData(store.params);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            if (triple.state.results.isEmpty && !triple.isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: EmptyWidget(
                    message: ExtraDataLabels.extraDataFormEmpty,
                    textButton: ExtraDataLabels.tryAgain,
                    onPressed: () => store.getExtraData(store.params),
                  ),
                ),
              ),
            if (triple.state.results.isNotEmpty)
              ListView.builder(
                itemCount: triple.state.results.length,
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                controller: scrollController,
                itemBuilder: (_, index) {
                  return SafeArea(
                    bottom: triple.state.results.last ==
                        triple.state.results[index],
                    child: DynamicFormWidget(
                      answerDynamicForm: store.answerExtraData,
                      getFields: store.getExtraDataById,
                      dynamicForm: triple.state.results[index],
                    ),
                  );
                },
              ),
            loading,
          ],
        );
      },
    );
  }
}
