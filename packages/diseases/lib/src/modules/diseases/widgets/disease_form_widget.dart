import 'package:dio/dio.dart';
import 'package:diseases/src/modules/diseases/stores/allergy_store.dart';
import 'package:diseases/src/modules/diseases/stores/disease_category_type_store.dart';
import 'package:diseases/src/modules/diseases/stores/disease_store.dart';
import 'package:diseases/src/modules/diseases/stores/new_diseases_store.dart';
import 'package:diseases_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class DiseaseFormWidget extends StatefulWidget {
  const DiseaseFormWidget({Key? key}) : super(key: key);

  @override
  State<DiseaseFormWidget> createState() => _DiseaseFormWidgetState();
}

class _DiseaseFormWidgetState extends State<DiseaseFormWidget> {
  final NewDiseasesStore store = Modular.get();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();

  final TextEditingController diseaseObservationController =
      TextEditingController();
  final TextEditingController allergyObservationController =
      TextEditingController();

  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  final DiseaseCategoryTypeStore diseaseCategoryStore = Modular.get();
  final DiseaseStore diseaseStore = Modular.get();
  final AllergyStore allergyStore = Modular.get();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.generalDiseases.results!.length !=
              store.generalDiseases.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getCidList(store.params);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
        store: diseaseCategoryStore,
        builder: (_, triple) {
          return Column(
            children: [
              diseaseCategoryStore.state == ''
                  ? Container()
                  : diseaseCategoryStore.state == 'Alergia'
                      ? _buildAllergyForm
                      : _buildDiseaseForm,
            ],
          );
        });
  }

  Widget get _buildAllergyForm {
    return Column(
      children: [
        TextFieldWidget(
            label: 'Alergia',
            controller: nameController,
            onChange: (value) {
              allergyStore.state.name = nameController.text;
              allergyStore.updateForm(allergyStore.state);
            }),
        TextFieldWidget(
          label: 'Observação',
          controller: allergyObservationController,
          onChange: (value) {
            allergyStore.state.observation = allergyObservationController.text;
            allergyStore.updateForm(allergyStore.state);
          },
        )
      ],
    );
  }

  Widget get _buildDiseaseForm {
    return Column(
      children: [
        TripleBuilder<NewDiseasesStore, DioError, List>(
          store: store,
          builder: (_, triple) {
            return TextFieldWidget(
              label: DiseasesLabels.createNewDiseaseDiseaseLabel,
              controller: diseaseController,
              readOnly: true,
              suffixIcon: triple.isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : SvgPicture.asset(
                      Assets.arrowDown,
                      color: Theme.of(context).cardColor,
                      package: AssetsPackage.omniGeneral,
                    ),
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => _buildChooseDiseaseSheetWidget(_),
                );
              },
            );
          },
        ),
        TextFieldWidget(
          label: DiseasesLabels.createNewDiseaseObservationLabel,
          controller: diseaseObservationController,
          onChange: (value) {
            diseaseStore.state.observation = diseaseObservationController.text;
            diseaseStore.updateForm(diseaseStore.state);
          },
        )
      ],
    );
  }

  Widget _buildChooseDiseaseSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BottomSheetHeaderWidget(
                  title: DiseasesLabels.createNewDiseaseSearchTitle,
                  searchPlaceholder:
                      DiseasesLabels.createNewDiseaseSearchPlaceholder,
                  showSearch: true,
                  controller: textController,
                  onSearch: (String? input) async {
                    QueryParamsModel params =
                        QueryParamsModel(name: input!, limit: '10');
                    await store.getCidList(params);
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: TripleBuilder<NewDiseasesStore, DioError, List>(
              store: store,
              builder: (_, triple) {
                if (triple.event == TripleEvent.error) {
                  return SafeArea(
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () {
                        QueryParamsModel params = QueryParamsModel(limit: '10');
                        store.getCidList(params);
                      },
                    ),
                  );
                }

                if (triple.isLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 25,
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const LoadingWidget(),
                          const SizedBox(height: 15),
                          Text(
                            DiseasesLabels.createNewDiseaseSearchItems,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  );
                }

                if (store.generalDiseases.results!.isEmpty) {
                  return const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 25,
                      ),
                      child: EmptyWidget(
                        message: DiseasesLabels.createNewDiseaseItemNotFound,
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!triple.isLoading) const SizedBox(height: 2.5),
                    if (triple.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          minHeight: 2.5,
                        ),
                      ),
                    Flexible(
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: store.generalDiseases.results!.length,
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 15,
                          ),
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 50,
                          ),
                          itemBuilder: (_, index) {
                            return AbsorbPointer(
                              absorbing: triple.isLoading,
                              child: Opacity(
                                opacity: triple.isLoading ? 0.5 : 1.0,
                                child: _buildDiseaseItemWidget(
                                  store.generalDiseases.results![index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseItemWidget(disease) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor.withOpacity(0.05),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Modular.to.pop();
          diseaseController.text = disease.name;
          diseaseStore.state.id = disease.id;
          diseaseStore.updateForm(diseaseStore.state);
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              disease.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              height: 10,
              width: 10,
              package: AssetsPackage.omniGeneral,
            ),
          ],
        ),
      ),
    );
  }
}
