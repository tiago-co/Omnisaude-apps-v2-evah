import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/measurement_text_form_field_widget.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class NewManualMeasurementPage extends StatefulWidget {
  final PageController pageController;
  final GlobalKey formKey;

  const NewManualMeasurementPage({
    Key? key,
    required this.pageController,
    required this.formKey,
  }) : super(key: key);

  @override
  _NewManualMeasurementPageState createState() =>
      _NewManualMeasurementPageState();
}

class _NewManualMeasurementPageState extends State<NewManualMeasurementPage> {
  @override
  void initState() {
    super.initState();
  }

  final NewMeasurementStore store = Modular.get<NewMeasurementStore>();
  final TextEditingController textController = TextEditingController();
  final TextEditingController textControllerSystolic = TextEditingController();
  final TextEditingController textControllerDiastolic = TextEditingController();
  final TextEditingController textControllerBPM = TextEditingController();

  String? dataSystolic = '';
  String? dataDiastolic = '';
  String? dataBPM = '';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: TripleBuilder<NewMeasurementStore, Exception, MeasurementModel>(
          store: store,
          builder: (_, triple) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        store.state.measurementType!.asset,
                        width: 40,
                        height: 40,
                        color: Theme.of(context).primaryColor,
                        package: 'omni_measurement',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        store.state.measurementType!.typeOfMonitoring,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${MeasurementLabels.newManualMeasurementReportMeasurement} ${store.state.measurementType!.pageTitle}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 35),
                  if (store.state.measurementType! != MeasurementType.pressure)
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: Form(
                        key: widget.formKey,
                        child: TextFormFieldPressure(
                          textController: textController,
                          measurementType: store.state.measurementType!,
                          onChangePressure: (String value) {
                            store.state.currentMeasure = value;
                            store.updateForm(store.state);
                          },
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (store.state.measurementType! != MeasurementType.pressure)
                    Text(
                      store.state.measurementType!.deviceMeasurementType,
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  else
                    Container(),
                  if (store.state.measurementType! == MeasurementType.pressure)
                    Form(
                      key: widget.formKey,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    TextFormFieldPressure(
                                      textController: textControllerSystolic,
                                      measurementType:
                                          store.state.measurementType!,
                                      onChangePressure: (String value) {
                                        dataSystolic = value;
                                        store.state.currentMeasure =
                                            '$dataSystolic/$dataDiastolic/$dataBPM';
                                        store.updateForm(store.state);
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      MeasurementLabels
                                          .newManualMeasurementSystole,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 9.0),
                              Text(
                                '/',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    TextFormFieldPressure(
                                      textController: textControllerDiastolic,
                                      measurementType:
                                          store.state.measurementType!,
                                      onChangePressure: (String value) {
                                        dataDiastolic = value;
                                        store.state.currentMeasure =
                                            '$dataSystolic/$dataDiastolic/$dataBPM';
                                        store.updateForm(store.state);
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      MeasurementLabels
                                          .newManualMeasurementDiastole,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            store.state.measurementType!.deviceMeasurementType,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    TextFormFieldPressure(
                                      textController: textControllerBPM,
                                      measurementType:
                                          store.state.measurementType!,
                                      onChangePressure: (String value) {
                                        dataBPM = value;
                                        store.state.currentMeasure =
                                            '$dataSystolic/$dataDiastolic/$dataBPM';
                                        store.updateForm(store.state);
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.favorite,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          MeasurementLabels
                                              .newManualMeasurementBPM,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
