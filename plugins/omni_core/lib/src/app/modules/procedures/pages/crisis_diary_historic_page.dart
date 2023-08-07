import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_historic_store.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:procedures_labels/labels.dart';

class CrisisDiaryHistoricPage extends StatefulWidget {
  const CrisisDiaryHistoricPage({Key? key}) : super(key: key);

  @override
  _CrisisDiaryHistoricPageState createState() =>
      _CrisisDiaryHistoricPageState();
}

class _CrisisDiaryHistoricPageState extends State<CrisisDiaryHistoricPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final CrisisDiaryHistoricStore store = Modular.get();

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
        store.getAnsweredCrisisDiaries(store.params);
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
              label: ProceduresLabels.crisisDiaryHistoricSearchLabel,
              placeholder:
                  ProceduresLabels.crisisDiaryHistoricSearchPlaceholder,
              controller: textEditingController,
              onChange: store.getAnsweredCrisisDiariesParams,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                    store.getAnsweredCrisisDiaries(store.params);
                  },
                  child: _buildCrisisDiaryHistoricListWidget,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () {},
        buttonType: BottomButtonType.outline,
        text: ProceduresLabels.crisisDiaryHistoricGenerateReport,
      ),
    );
  }

  Widget get _buildCrisisDiaryHistoricListWidget {
    return TripleBuilder<CrisisDiaryHistoricStore, DioError,
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
                        store.getAnsweredCrisisDiaries(store.params);
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
                    message: ProceduresLabels.crisisDiaryHistoricEmpty,
                    textButton: ProceduresLabels.crisisDiaryHistoricTryAgain,
                    onPressed: () => store.getAnsweredCrisisDiaries(
                      store.params,
                    ),
                  ),
                ),
              ),
            if (triple.state.results.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: triple.state.results.length,
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                  ),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: scrollController,
                  itemBuilder: (_, index) {
                    return DynamicFormWidget(
                      readOnly: true,
                      getFields: store.getAnsweredCrisisDiaryById,
                      dynamicForm: triple.state.results[index],
                    );
                  },
                ),
              ),
            loading,
          ],
        );
      },
    );
  }
}
