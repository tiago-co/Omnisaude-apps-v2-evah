import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement_labels/labels.dart';

class NewMeasurementResumeData extends StatelessWidget {
  final NewMeasurementStore store = Modular.get();

  NewMeasurementResumeData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).cardColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                MeasurementLabels.newMeasurementResumeDataMeasurementResume,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).cardColor,
                      // fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(
            color: Theme.of(context).cardColor.withOpacity(0.5),
          ),
          // const SizedBox(height: 15),
          Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: _buildMeasurementInfoWidget(context),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 4,
                child: _buildMeasurementDetailsWidget(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementInfoWidget(BuildContext context) {
    String endCurrentMeasure = store.state.currentMeasure!;
    String pressureBPM = '';
    int myIndex;

    if (store.state.measurementType == MeasurementType.pressure) {
      myIndex = store.state.currentMeasure!.indexOf('/');

      myIndex = store.state.currentMeasure!.indexOf('/', myIndex + 1);

      endCurrentMeasure = store.state.currentMeasure!.substring(0, myIndex);
      pressureBPM = store.state.currentMeasure!.substring(myIndex + 1);
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(
              store.state.measurementType!.asset,
              height: 40,
              color: Theme.of(context).primaryColor,
              package: 'omni_measurement',
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      store.state.measurementType!.typeOfMonitoring,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              endCurrentMeasure,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              store
                                  .state.measurementType!.deviceMeasurementType,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        if (store.state.measurementType == MeasurementType.pressure)
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 2.0,
                ),
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).primaryColor,
                  size: 20.0,
                ),
              ),
              Text(
                pressureBPM,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(width: 5.0),
              Text(
                MeasurementLabels.newMeasurementResumeDataBPM,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMeasurementDetailsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.calendar_month_rounded,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Text(
                  Formaters.dateToStringDate(
                    DateTime.tryParse(store.state.date.toString()) ??
                        DateTime.now(),
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: <Widget>[
            Icon(
              Icons.watch_later_sharp,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Text(
                  Formaters.dateToStringTime(
                    DateTime.tryParse(store.state.date.toString()) ??
                        DateTime.now(),
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
