import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/enums/feeling_type_enum.dart';
import 'package:omni_measurement/src/core/enums/meal_type_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement_labels/labels.dart';

class MeasurementDetailsBodyWidget extends StatelessWidget {
  final MeasurementModel measurement;
  const MeasurementDetailsBodyWidget({Key? key, required this.measurement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MeasurementLabels.measurementDetailsBodyInformation,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        SizedBox(
          height: 20,
          child: Divider(
            color: Theme.of(context).cardColor.withOpacity(0.25),
          ),
        ),
        RowTextFieldWidget(
          label: MeasurementLabels.measurementDetailsBodyMeasurementType,
          value: measurement.measurementType!.label,
        ),
        RowTextFieldWidget(
          label: MeasurementLabels.measurementDetailsBodyDate,
          value: Formaters.dateToStringDate(
            Formaters.stringToDateTime(measurement.date!),
          ),
        ),
        RowTextFieldWidget(
          label: MeasurementLabels.measurementDetailsBodyHour,
          value: Formaters.dateToStringTime(
            Formaters.stringToDateTime(measurement.date!),
          ),
        ),
        RowTextFieldWidget(
          label: MeasurementLabels.measurementDetailsBodyHowAreYouFeeling,
          value: measurement.howAreYouFeeling?.label,
        ),
        if (measurement.measurementType == MeasurementType.glucose)
          RowTextFieldWidget(
            label: MeasurementLabels.measurementDetailsBodyMeal,
            value: measurement.meal?.label,
          ),
      ],
    );
  }
}
