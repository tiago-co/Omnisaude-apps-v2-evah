import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_medicine_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlMedicinesWidget extends StatefulWidget {
  final bool useCustomMedication;

  const NewDrugControlMedicinesWidget({
    Key? key,
    required this.useCustomMedication,
  }) : super(key: key);

  @override
  _NewDrugControlMedicinesWidgetState createState() =>
      _NewDrugControlMedicinesWidgetState();
}

class _NewDrugControlMedicinesWidgetState
    extends State<NewDrugControlMedicinesWidget> {
  final NewDrugControlMedicineStore store = Modular.get();
  final NewDrugControlStore drugControlStore = Modular.get();
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController medicineController = TextEditingController();

  @override
  void initState() {
    store.params.limit = '30';
    scrollController.addListener(() {
      if (widget.useCustomMedication) {
        if (scrollController.offset ==
                scrollController.position.maxScrollExtent &&
            store.customMedicines.results!.length !=
                store.customMedicines.count) {
          store.params.limit = (int.parse(store.params.limit!) + 10).toString();
          store.getMedicines(store.params, widget.useCustomMedication);
        }
      } else {
        if (scrollController.offset ==
                scrollController.position.maxScrollExtent &&
            store.generalMedicines.results!.length !=
                store.generalMedicines.count) {
          store.params.limit = (int.parse(store.params.limit!) + 10).toString();
          store.getMedicines(store.params, widget.useCustomMedication);
        }
      }
    });
    store.getMedicines(store.params, widget.useCustomMedication);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    medicineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<NewDrugControlMedicineStore, DioError, List>(
      store: store,
      builder: (_, triple) {
        return TextFieldWidget(
          label: DrugControlLabels.newDrugControlMedicineLabel,
          controller: medicineController,
          placeholder: DrugControlLabels.newDrugControlMedicinePlaceholder,
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
              builder: (_) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: _buildChooseMedicineSheetWidget(_),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChooseMedicineSheetWidget(BuildContext context) {
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
                  title: DrugControlLabels.newDrugControlMedicineSearchTitle,
                  searchPlaceholder:
                      DrugControlLabels.newDrugControlMedicineSearchPlaceholder,
                  showSearch: true,
                  controller: textController,
                  onSearch: (String? input) {
                    store.getMedicinesParams(
                      input,
                      widget.useCustomMedication,
                    );
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: TripleBuilder<NewDrugControlMedicineStore, DioError, List>(
              store: store,
              builder: (_, triple) {
                if (triple.event == TripleEvent.error) {
                  return SafeArea(
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () {
                        store.getMedicines(
                          store.params,
                          widget.useCustomMedication,
                        );
                      },
                    ),
                  );
                }

                if ((widget.useCustomMedication
                        ? store.customMedicines.results!.isEmpty
                        : store.generalMedicines.results!.isEmpty) &&
                    triple.isLoading) {
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
                            DrugControlLabels
                                .newDrugControlMedicineSearchLoading,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  );
                }

                if (widget.useCustomMedication
                    ? store.customMedicines.results!.isEmpty
                    : store.generalMedicines.results!.isEmpty) {
                  return const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 25,
                      ),
                      child: EmptyWidget(
                        message:
                            DrugControlLabels.newDrugControlMedicineListEmpty,
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
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.useCustomMedication
                              ? store.customMedicines.results!.length
                              : store.generalMedicines.results!.length,
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
                                child: _buildMedicineItemWidget(
                                  widget.useCustomMedication
                                      ? store.customMedicines.results![index]
                                      : store.generalMedicines.results![index],
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

  Widget _buildMedicineItemWidget(medicine) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor.withOpacity(0.05),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          if (widget.useCustomMedication) {
            medicineController.text = Formaters.capitalize(medicine.value);
            drugControlStore.state.medicine = medicine.id.toString();
          } else {
            medicineController.text = Formaters.capitalize(medicine.name);
            drugControlStore.state.medicine = medicine.id.toString();
          }
          FocusScope.of(context).requestFocus(FocusNode());
          Modular.to.pop();
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              widget.useCustomMedication ? medicine.value : medicine.name,
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
