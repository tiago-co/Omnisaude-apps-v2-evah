import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/core/models/mediktor_measurement_type_model.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/measurement_type_toggle_type_widget.dart';
import 'package:omni_measurement/src/new_measurement/stores/bottom_button_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/mediktor_measurement_type_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class MeasurementTypePage extends StatefulWidget {
  final String specialtyId;
  final Function(MeasurementModel, MeasurementType) nextOrCreateMeasurement;
  const MeasurementTypePage({
    Key? key,
    required this.specialtyId,
    required this.nextOrCreateMeasurement,
  }) : super(key: key);

  @override
  _MeasurementTypePageState createState() => _MeasurementTypePageState();
}

class _MeasurementTypePageState extends State<MeasurementTypePage> {
  final NewMeasurementStore store = Modular.get<NewMeasurementStore>();
  final BottomButtonStore bottomButtonStore = Modular.get<BottomButtonStore>();
  final MediktorMeasurementTypeStore typeStore =
      Modular.get<MediktorMeasurementTypeStore>();

  @override
  void initState() {
    if (widget.specialtyId.isNotEmpty) {
      typeStore.getMediktorMeasurementsType(widget.specialtyId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                MeasurementLabels.measurementTypeDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 40),
              TripleBuilder<NewMeasurementStore, Exception, MeasurementModel>(
                store: store,
                builder: (_, triple) {
                  if (triple.isLoading) {
                    return const LoadingWidget();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: widget.specialtyId == ''
                          ? Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: MeasurementTypeToggleWidget(
                                        isActive:
                                            triple.state.measurementType ==
                                                MeasurementType.glucose,
                                        type: MeasurementType.glucose,
                                        form: store.state,
                                        onTap: widget.nextOrCreateMeasurement,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: MeasurementTypeToggleWidget(
                                        isActive:
                                            triple.state.measurementType ==
                                                MeasurementType.oxygen,
                                        type: MeasurementType.oxygen,
                                        form: store.state,
                                        onTap: widget.nextOrCreateMeasurement,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: MeasurementTypeToggleWidget(
                                        isActive:
                                            triple.state.measurementType ==
                                                MeasurementType.pressure,
                                        type: MeasurementType.pressure,
                                        form: store.state,
                                        onTap: widget.nextOrCreateMeasurement,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: MeasurementTypeToggleWidget(
                                        isActive:
                                            triple.state.measurementType ==
                                                MeasurementType.temperature,
                                        type: MeasurementType.temperature,
                                        form: store.state,
                                        onTap: widget.nextOrCreateMeasurement,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : ScopedBuilder<MediktorMeasurementTypeStore,
                              DioError, MediktorMeasurementTypeModel>(
                              store: typeStore,
                              onError: (_, onError) => RequestErrorWidget(
                                error: onError,
                                onPressed: () => Modular.to.pop(),
                              ),
                              onLoading: (_) => const LoadingWidget(),
                              onState: (_, triple) {
                                return GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  children: [
                                    for (String measurementType
                                        in typeStore.state.tiposMedicao!)
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: MeasurementTypeToggleWidget(
                                          type: measurementTypeFromJson(
                                            measurementType,
                                          )!,
                                          isActive:
                                              store.state.measurementType ==
                                                  measurementTypeFromJson(
                                                    measurementType,
                                                  )!,
                                          form: store.state,
                                          onTap: widget.nextOrCreateMeasurement,
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
