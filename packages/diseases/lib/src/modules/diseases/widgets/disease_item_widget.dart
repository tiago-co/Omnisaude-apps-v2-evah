import 'package:diseases/src/core/allergies_list_results_model.dart';
import 'package:diseases/src/modules/diseases/stores/new_diseases_store.dart';
import 'package:diseases_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

import '../../../core/diseases_list_results_model.dart';
import '../stores/alergies_list_store.dart';
import '../stores/diseases_list_store.dart';

class DiseaseItemWidget extends StatelessWidget {
  final DiseasesListResultsModel? diseaseItem;
  final AllergiesListResultsModel? allergyItem;
  final String typeTitle;
  final String assetPath;
  const DiseaseItemWidget(
      {Key? key,
      this.diseaseItem,
      this.allergyItem,
      required this.typeTitle,
      required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        assetPath,
                        package: AssetsPackage.omniGeneral,
                        color: Theme.of(context).primaryColor,
                        width: 40,
                        height: 40,
                      ),
                      Text(
                        typeTitle,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Helpers.showDialog(
                        context,
                        _buildRemoveDiseaseWidget(context),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        DiseasesLabels.alergyLabel,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              diseaseItem != null
                  ? Text(
                      diseaseItem!.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  : Text(
                      allergyItem!.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
              const SizedBox(
                height: 15,
              ),
              diseaseItem != null
                  ? Text(
                      diseaseItem!.observation ?? '',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                          ),
                    )
                  : Text(
                      allergyItem!.observation ?? '',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                          ),
                    ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildRemoveDiseaseWidget(BuildContext context) {
    final NewDiseasesStore store = Modular.get();
    final DiseasesListStore diseasesListStore = Modular.get();
    final AllergiesListStore allergiesListStore = Modular.get();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          diseaseItem != null
              ? Text(
                  '${DiseasesLabels.allergyListConfirmExclusion}'
                  '${diseaseItem!.name}?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                )
              : Text(
                  '${DiseasesLabels.allergyListConfirmExclusion}'
                  '${allergyItem!.name}?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () => Navigator.pop(context),
                  text: DiseasesLabels.allergyListCancel,
                  buttonType: DefaultButtonType.outline,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.red),
                  child: DefaultButtonWidget(
                    onPressed: () {
                      Modular.to.pop();
                      if (typeTitle == 'Patologia') {
                        store
                            .removeDisease(diseaseItem!.id!)
                            .then((value) async {
                          await Helpers.showDialog(
                            context,
                            SuccessWidget(
                              message: DiseasesLabels.allergyListSuccessRemove,
                              onPressed: () {
                                Modular.to.pop();
                              },
                            ),
                          );
                          await diseasesListStore.getDiseasesList();
                        }).catchError(
                          (onError) {
                            Helpers.showDialog(
                              context,
                              RequestErrorWidget(
                                message: onError.toString(),
                                onPressed: () {
                                  Modular.to.pop();
                                },
                                buttonText: DiseasesLabels.close,
                              ),
                            );
                          },
                        );
                      } else {
                        store
                            .removeAllergy(allergyItem!.id!)
                            .then((value) async {
                          await Helpers.showDialog(
                            context,
                            SuccessWidget(
                              message: DiseasesLabels.allergyListSuccessRemove,
                              onPressed: () {
                                Modular.to.pop();
                              },
                            ),
                          );
                          await allergiesListStore.getAllergiesList();
                        }).catchError(
                          (onError) {
                            Helpers.showDialog(
                              context,
                              RequestErrorWidget(
                                message: onError.toString(),
                                onPressed: () {
                                  Modular.to.pop();
                                },
                                buttonText: DiseasesLabels.close,
                              ),
                            );
                          },
                        );
                      }
                    },
                    text: DiseasesLabels.allergyListRemove,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
