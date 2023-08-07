import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement_labels/labels.dart';

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final double min;
  final double max;
  final String setValue = '';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: setValue);
    } else if (value > max.toInt()) {
      return TextEditingValue(text: setValue);
    }
    return newValue;
  }
}

class TextFormFieldPressure extends StatelessWidget {
  final TextEditingController textController;
  final Function(String)? onChangePressure;
  final MeasurementType measurementType;

  const TextFormFieldPressure({
    Key? key,
    required this.textController,
    required this.onChangePressure,
    required this.measurementType,
  }) : super(key: key);

  List<TextInputFormatter> get setFormatters {
    switch (measurementType) {
      case MeasurementType.glucose:
        return [
          LengthLimitingTextInputFormatter(3),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
        ];
      case MeasurementType.oxygen:
        return [
          LengthLimitingTextInputFormatter(3),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LimitRangeTextInputFormatter(1, 100),
        ];
      case MeasurementType.pressure:
        return [
          LengthLimitingTextInputFormatter(3),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LimitRangeTextInputFormatter(1, 300),
        ];
      case MeasurementType.temperature:
        return [
          LengthLimitingTextInputFormatter(4),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]+')),
        ];
      default:
        return [
          LengthLimitingTextInputFormatter(3),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: setFormatters,
      controller: textController,
      textAlign: TextAlign.center,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: Theme.of(context).primaryColor,
      ),
      validator: (value) {
        try {
          double.parse(value.toString());
          return null;
        } catch (e) {
          return MeasurementLabels.measurementTextFormField;
        }
      },
      onChanged: onChangePressure,
    );
  }
}
