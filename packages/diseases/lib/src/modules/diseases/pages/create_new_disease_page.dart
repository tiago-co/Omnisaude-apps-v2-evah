import 'package:dio/dio.dart';
import 'package:diseases/src/core/allergy_model.dart';
import 'package:diseases/src/modules/diseases/stores/alergies_list_store.dart';
import 'package:diseases/src/modules/diseases/stores/allergy_store.dart';
import 'package:diseases/src/modules/diseases/stores/disease_category_type_store.dart';
import 'package:diseases/src/modules/diseases/stores/disease_store.dart';
import 'package:diseases/src/modules/diseases/stores/diseases_list_store.dart';
import 'package:diseases/src/modules/diseases/stores/new_diseases_store.dart';
import 'package:diseases_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

import '../../../core/diseases_model.dart';
import '../widgets/category_type_textfield_widget.dart';
import '../widgets/disease_form_widget.dart';

class CreateNewDiseasePage extends StatefulWidget {
  const CreateNewDiseasePage({Key? key}) : super(key: key);

  @override
  State<CreateNewDiseasePage> createState() => _CreateNewDiseasePageState();
}

class _CreateNewDiseasePageState extends State<CreateNewDiseasePage> {
  final NewDiseasesStore store = Modular.get();
  final DiseasesListStore diseaseListStore = Modular.get();
  final DiseaseStore diseasesStore = Modular.get();
  final AllergyStore allergyStore = Modular.get();
  final DiseaseCategoryTypeStore diseaseCategoryStore = Modular.get();
  final AllergiesListStore allergiesListStore = Modular.get();

  @override
  void initState() {
    store.getCidList(QueryParamsModel(limit: '10'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(title: DiseasesLabels.createNewDiseaseTitle)
          .build(context) as AppBar,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const CategoryTextFieldWidget(),
            TripleBuilder<DiseaseCategoryTypeStore, Exception, String>(
              store: diseaseCategoryStore,
              builder: (context, triple) {
                return const DiseaseFormWidget();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder<NewDiseasesStore, DioError, List>(
        store: store,
        builder: (_, triple) {
          if (triple.event == TripleEvent.error) {
            Helpers.showDialog(
              context,
              RequestErrorWidget(
                buttonText: DiseasesLabels.close,
                error: triple.error,
                onPressed: () => Modular.to.pop(),
              ),
            );
          }
          return BottomButtonWidget(
            isDisabled: triple.isLoading,
            isLoading: triple.isLoading,
            onPressed: () {
              if (diseaseCategoryStore.state == 'Alergia') {
                store.saveAllergy(allergyStore.state).then(
                  (value) async {
                    await Helpers.showDialog(
                      context,
                      SuccessWidget(
                        message:
                            DiseasesLabels.createNewDiseaseSaveAllergySuccess,
                        onPressed: () {
                          Modular.to.pop();
                          allergiesListStore.getAllergiesList();
                          allergyStore.updateForm(AllergyModel());
                        },
                      ),
                    );

                    Modular.to.pop();
                    allergyStore.updateForm(AllergyModel());
                  },
                );
              }

              if (diseaseCategoryStore.state == 'Patologia') {
                store.saveDisease(diseasesStore.state).then(
                  (value) async {
                    await Helpers.showDialog(
                      context,
                      SuccessWidget(
                        message:
                            DiseasesLabels.createNewDiseaseSaveDiseaseSuccess,
                        onPressed: () {
                          Modular.to.pop();
                        },
                      ),
                    );

                    Modular.to.pop();
                    await diseaseListStore.getDiseasesList();
                    diseasesStore.updateForm(DiseasesModel());
                  },
                );
              }
            },
            buttonType: BottomButtonType.outline,
            text: DiseasesLabels.createNewDiseaseSave,
          );
        },
      ),
    );
  }
}
