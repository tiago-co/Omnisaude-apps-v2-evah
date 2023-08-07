import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/measurement_historic/pages/widgets/historic_item_shimmer_widget.dart';
import 'package:omni_measurement/src/measurement_historic/pages/widgets/measurement_date_filter_widget.dart';
import 'package:omni_measurement/src/measurement_historic/pages/widgets/vertical_timeline_measurement_widget.dart';
import 'package:omni_measurement/src/measurement_historic/stores/measurement_historic_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/bottom_button_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class MeasurementHistoricPage extends StatefulWidget {
  final String moduleName;
  const MeasurementHistoricPage({Key? key, required this.moduleName})
      : super(key: key);

  @override
  _MeasurementHistoricPageState createState() =>
      _MeasurementHistoricPageState();
}

class _MeasurementHistoricPageState extends State<MeasurementHistoricPage> {
  final MeasurementHistoricStore store = Modular.get();
  final NewMeasurementStore newMeasurementStore = Modular.get();
  final ScrollController scrollController = ScrollController();
  final DatePickerController dateController = DatePickerController();

  @override
  void initState() {
    super.initState();
    store.params.limit = '10';
    final DateTime now = DateTime.now();
    store.params.startDate = Formaters.dateToStringDate(
      DateTime(now.year, now.month),
    );
    store.params.endDate = Formaters.dateToStringDate(
      DateTime(now.year, now.month + 1, 0),
    );
    store.params.date = Formaters.dateToStringDate(now);
    store.getMeasurementDays(store.params, now).then((day) {
      dateController.setDateAndAnimate(
        DateTime(now.year, now.month, day!),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );
    });
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.measurements.results!.length != store.measurements.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getMeasurements(store.params);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BottomButtonStore bottomButtonStore = Modular.get();
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          MeasurementDateFilterWidget(dateController: dateController),
          const Divider(),
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
                  store.getMeasurements(store.params);
                },
                child: _buildMeasurementListWidget,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          TripleBuilder<MeasurementHistoricStore, DioError, List<DateTime>>(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: triple.isLoading,
            buttonType: BottomButtonType.values[0],
            onPressed: () {
              newMeasurementStore.counterButton = 0;
              newMeasurementStore.counterPage = 0;
              newMeasurementStore.categoryStep = 0;
              bottomButtonStore.updateButton(false);
              Modular.to.pushNamed(
                '/home/measurements/newMeasurement',
                arguments: {
                  'moduleName': 'Nova Medição',
                  'specialtyId': '',
                },
              );
            },
            text: MeasurementLabels.measurementHistoricNewMeasurement,
          );
        },
      ),
    );
  }

  Widget get _buildMeasurementListWidget {
    return TripleBuilder<MeasurementHistoricStore, DioError, List<DateTime>>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const HistoricItemShimmerWidget();
        }

        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () => store.getMeasurements(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            if (store.measurements.results!.isEmpty)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message: MeasurementLabels.measurementHistoricEmpty,
                          textButton:
                              MeasurementLabels.measurementHistoricUpdate,
                          onPressed: () => store.getMeasurements(store.params),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (store.measurements.results!.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: store.measurements.results!.length,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (_, index) {
                    index = store.measurements.results!.length - index - 1;
                    return SafeArea(
                      bottom: store.measurements.results!.last ==
                          store.measurements.results![index],
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/home/measurements/historic/measurement_details',
                            arguments: store.measurements.results![index],
                          );
                        },
                        child: VerticalTimelineMeasurementWidget(
                          measurementType: store
                              .measurements.results![index].measurementType!,
                          child: _buildMeasurementItemWidget(
                            store.measurements.results![index],
                          ),
                        ),
                      ),
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

  Widget _buildMeasurementItemWidget(MeasurementModel measurement) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  measurement.measurementType?.label ??
                      MeasurementLabels.measurementHistoricTypeNoName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                // const SizedBox(width: 15),
                const Spacer(),
                Icon(
                  measurement.measurementMode == MeasurementMode.camera
                      ? Icons.camera_alt_rounded
                      : measurement.measurementMode == MeasurementMode.automatic
                          ? Icons.bluetooth
                          : Icons.touch_app_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 7.5),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${measurement.currentMeasure} '
                  '${measurement.measurementType!.deviceMeasurementType}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                ),
                Text(
                  Formaters.dateToStringTime(
                    Formaters.stringToDateTime(measurement.date!),
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
