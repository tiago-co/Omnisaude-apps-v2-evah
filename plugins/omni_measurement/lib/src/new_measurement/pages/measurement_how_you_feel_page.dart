import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/enums/feeling_type_enum.dart';
import 'package:omni_measurement/src/core/enums/meal_type_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/how_are_you_feeling_type_widget.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/new_measurement_resume_data.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class MeasurementHowYouFeelPage extends StatefulWidget {
  final PageController pageController;

  const MeasurementHowYouFeelPage({Key? key, required this.pageController})
      : super(key: key);

  @override
  _MeasurementHowYouFeelPageState createState() =>
      _MeasurementHowYouFeelPageState();
}

class _MeasurementHowYouFeelPageState extends State<MeasurementHowYouFeelPage> {
  final TextEditingController mealsSelectTextController =
      TextEditingController();
  final TextEditingController observationsTextController =
      TextEditingController();

  final NewMeasurementStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  NewMeasurementResumeData(),
                  const SizedBox(height: 20),
                  Text(
                    MeasurementLabels.measurementHowYouFeelDescription,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 30),
                  TripleBuilder<NewMeasurementStore, Exception,
                      MeasurementModel>(
                    store: store,
                    builder: (_, triple) {
                      return SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: HowAreYouFeelingTypeWidget(
                                type: AreYouFeeling.good,
                                isActive: triple.state.howAreYouFeeling ==
                                    AreYouFeeling.good,
                                onTap: store.onChangeAreYouFeeling,
                                icon: const Icon(
                                  Icons.face,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: HowAreYouFeelingTypeWidget(
                                type: AreYouFeeling.normal,
                                isActive: triple.state.howAreYouFeeling ==
                                    AreYouFeeling.normal,
                                onTap: store.onChangeAreYouFeeling,
                                icon: const Icon(
                                  Icons.face,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: HowAreYouFeelingTypeWidget(
                                type: AreYouFeeling.bad,
                                isActive: triple.state.howAreYouFeeling ==
                                    AreYouFeeling.bad,
                                onTap: store.onChangeAreYouFeeling,
                                icon: const Icon(
                                  Icons.face,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  if (store.state.measurementType == MeasurementType.glucose)
                    SelectFieldWidget<MealType>(
                      label: MeasurementLabels.measurementHowYouFeelMealsLabel,
                      items: const <MealType>[
                        MealType.prePrandial,
                        MealType.posPrandial,
                        MealType.emJejum,
                        MealType.aoDeitar,
                      ],
                      placeholder: MeasurementLabels
                          .measurementHowYouFeelMealsPlaceholder,
                      controller: mealsSelectTextController,
                      itemsLabels: <String>[
                        MealType.prePrandial.label,
                        MealType.posPrandial.label,
                        MealType.emJejum.label,
                        MealType.aoDeitar.label,
                      ],
                      onSelectItem: (MealType type) {
                        store.state.meal = type;
                        mealsSelectTextController.text =
                            store.state.meal!.label;
                        store.updateForm(store.state);
                      },
                    ),
                  const SizedBox(height: 15),
                  TextFieldWidget(
                    label:
                        MeasurementLabels.measurementHowYouFeelObservationLabel,
                    controller: observationsTextController,
                    onChange: (observations) {
                      store.state.observations = observations;
                      store.updateForm(store.state);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
