import 'package:dio/dio.dart';
import 'package:extra_data_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_historic_store.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_widget.dart';
import 'package:omni_general/omni_general.dart';

class ExtraDataHistoricPage extends StatefulWidget {
  const ExtraDataHistoricPage({Key? key}) : super(key: key);

  @override
  _ExtraDataHistoricPageState createState() => _ExtraDataHistoricPageState();
}

class _ExtraDataHistoricPageState extends State<ExtraDataHistoricPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ExtraDataHistoricStore store = Modular.get();

  @override
  void dispose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getAnsweredExtraData(store.params);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFieldWidget(
              label: ExtraDataLabels.extraDataHistoricSearchLabel,
              placeholder: ExtraDataLabels.extraDataHistoricSearchPlaceholder,
              controller: textEditingController,
              // onChange: store.getAnsweredCrisisDiariesParams,
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
                backgroundColor: Theme.of(context).colorScheme.background,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () async {
                  store.getAnsweredExtraData(store.params);
                },
                child: _buildExtraDataHistoricListWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildExtraDataHistoricListWidget {
    return TripleBuilder<ExtraDataHistoricStore, DioError,
        DynamicFormResultsModel>(
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
                        store.getAnsweredExtraData(store.params);
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
                    message: ExtraDataLabels.extraDataHistoricEmpty,
                    textButton:ExtraDataLabels.tryAgain,
                    onPressed: () => store.getAnsweredExtraData(store.params),
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
                      readOnly: true,
                      getFields: store.getAnsweredExtraDataById,
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
