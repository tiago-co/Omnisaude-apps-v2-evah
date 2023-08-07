import 'package:dio/dio.dart';
import 'package:exams_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/new_exam_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/exams/stores/exams_store.dart';
import 'package:omni_core/src/app/modules/exams/widgets/exams_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/exams/widgets/exams_item_widget.dart';
import 'package:omni_general/omni_general.dart';

class ExamsPage extends StatefulWidget {
  const ExamsPage({Key? key}) : super(key: key);
  @override
  ExamsPageState createState() => ExamsPageState();
}

class ExamsPageState extends State<ExamsPage> {
  final ExamsStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    store.getExams(store.params);
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getExams(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const NavBarWidget(title: ExamsLabels.examsTitle).build(context)
          as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFieldWidget(
                    label: ExamsLabels.examsSearchLabel,
                    controller: textController,
                    placeholder: ExamsLabels.examsSearchPlaceholder,
                    onChange: (String? input) {
                      store.getExamsByName(input, store.params);
                    },
                    suffixIcon: SvgPicture.asset(
                      Assets.search,
                      package: AssetsPackage.omniGeneral,
                      width: 25,
                      height: 25,
                    ),
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
                        store.getExams(store.params);
                      },
                      child: _buildExamsListWidget,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () {
          Modular.to.pushNamed('/home/exams/new_exam');
        },
        buttonType: BottomButtonType.outline,
        text: ExamsLabels.examsAdd,
      ),
    );
  }

  Widget get _buildExamsListWidget {
    return TripleBuilder<ExamsStore, DioError, ExamsResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) loading = const ExamsItemShimmerWidget();

        if (triple.event == TripleEvent.error) {
          Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const BouncingScrollPhysics(),
                    child: EmptyWidget(
                      message: ExamsLabels.examsEmpty,
                      textButton: ExamsLabels.tryAgain,
                      onPressed: () => store.getExams(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            if (triple.state.results!.isEmpty)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message: ExamsLabels.examsEmpty,
                          textButton: ExamsLabels.tryAgain,
                          onPressed: () => store.getExams(store.params),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (triple.state.results!.isNotEmpty)
              ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: triple.state.results!.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (_, index) {
                  return ExamsItemWidget(
                    exams: triple.state.results![index],
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
