import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/dynamic_form_field_enum.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_field_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/procedures/pages/crisis_diary_historic_page.dart';
import 'package:omni_core/src/app/modules/procedures/pages/widgets/crisis_diary_type_filter_widget.dart';
import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_store.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_field_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_input_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_select_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_upload_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:procedures_labels/labels.dart';
import 'package:shimmer/shimmer.dart';

class CrisisDiaryPage extends StatefulWidget {
  final String moduleName;

  const CrisisDiaryPage({Key? key, required this.moduleName}) : super(key: key);

  @override
  _CrisisDiaryPageState createState() => _CrisisDiaryPageState();
}

class _CrisisDiaryPageState extends State<CrisisDiaryPage> {
  final CrisisDiaryStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    store.getCrisisDiary();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    pageController.dispose();
    scrollController.dispose();
    store.historicStore.destroy();
    super.dispose();
  }

  void answerCrisisDiary() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!formKey.currentState!.validate()) return;
    store.answerCrisisDiary(store.answerForm).then((value) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          message: ProceduresLabels.crisisDiarySuccess,
          buttonText: ProceduresLabels.close,
          onPressed: () => Modular.to.pop(),
        ),
      );
    }).catchError(
      (onError) {
        Helpers.showDialog(
          context,
          RequestErrorWidget(
            error: onError,
            buttonText: ProceduresLabels.close,
            onPressed: () => Modular.to.pop(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CrisisDiaryTypeFilterWidget(
                pageController: pageController,
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      _buildCrisisDiaryHeaderWidget,
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
                              store.getCrisisDiary();
                            },
                            child: _buildCrisisDiaryFormWidget,
                          ),
                        ),
                      ),
                      BottomButtonWidget(
                        onPressed: answerCrisisDiary,
                        buttonType: BottomButtonType.outline,
                        text: ProceduresLabels.crisisDiarySave,
                      ),
                    ],
                  ),
                  const CrisisDiaryHistoricPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildCrisisDiaryHeaderWidget {
    return TripleBuilder<CrisisDiaryStore, DioError, DynamicFormModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
              highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 10,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.white),
                ],
              ),
            ),
          );
        }

        if (triple.state.fields!.isEmpty) return const SizedBox();

        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15),
                Text(
                  triple.state.name ?? ProceduresLabels.crisisDiaryNoTitle,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  triple.state.description ??
                      ProceduresLabels.crisisDiaryNoDescription,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                ),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _buildCrisisDiaryFormWidget {
    return TripleBuilder<CrisisDiaryStore, DioError, DynamicFormModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return const DynamicFormFieldShimmerWidget();
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
                      onPressed: () => store.getCrisisDiary(),
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
            if (triple.state.fields!.isEmpty && !triple.isLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: EmptyWidget(
                    message: ProceduresLabels.crisisDiaryEmpty,
                    textButton: ProceduresLabels.tryAgain,
                    onPressed: () {
                      // store.getProcedures(store.params);
                    },
                  ),
                ),
              ),
            if (triple.state.fields!.isNotEmpty)
              GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Form(
                  key: formKey,
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: triple.state.fields!.length,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemBuilder: (_, index) {
                        return SafeArea(
                          bottom: triple.state.fields!.last ==
                              triple.state.fields![index],
                          child: _buildFieldItemWidget(
                            triple.state.fields![index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFieldItemWidget(DynamicFormFieldModel field) {
    final List<FieldModel> formFields = List.from(store.answerForm.fields);
    switch (field.type) {
      case DynamicFormType.input:
        final int indexOf = formFields.indexWhere((obj) => obj.id == field.id);
        return DynamicInputWidget(
          input: field.inputField!,
          onChangeAnswer: (String? answer) {
            formFields[indexOf].value = answer ?? '';
          },
        );
      case DynamicFormType.upload:
        return DynamicUploadWidget(
          upload: field.uploadField!,
        );
      case DynamicFormType.select:
        final int indexOf = formFields.indexWhere((obj) => obj.id == field.id);
        return DynamicSelectWidget(
          select: field.selectField!,
          onChangeAnswer: (String? answer) {
            formFields[indexOf].value = answer ?? '';
          },
        );
      default:
        return const SizedBox();
    }
  }
}
