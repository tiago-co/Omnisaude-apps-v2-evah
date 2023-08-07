library cupertino_date_textbox;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/coparticipation_extract_store.dart';

class DateTextBoxWidget extends StatefulWidget {
  const DateTextBoxWidget({
    required this.initialValue,
    required this.onDateChange,
    required this.hintText,
    this.uptadeDate,
    this.color = CupertinoColors.label,
    this.hintColor = CupertinoColors.inactiveGray,
    this.pickerBackgroundColor = CupertinoColors.systemBackground,
    this.fontSize = 17.0,
    this.textfieldPadding = 15.0,
    this.enabled = true,
  });

  final DateTime? initialValue;
  final Function onDateChange;
  final String hintText;
  final Color color;
  final Color hintColor;
  final Color pickerBackgroundColor;
  final double fontSize;
  final double textfieldPadding;
  final bool enabled;
  final Function? uptadeDate;

  @override
  _DateTextBoxWidgetState createState() => _DateTextBoxWidgetState();
}

class _DateTextBoxWidgetState extends State<DateTextBoxWidget> {
  final double _kPickerSheetHeight = 250.0;
  CoparticipationExtractStore store = Modular.get();

  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialValue;
  }

  void callCallback() {}

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
          color: widget.color,
          fontSize: 20.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  void onSelectedDate(DateTime date) {
    setState(() {
      _currentDate = date;
    });
  }

  Widget _buildTextField(String hintText, Function onSelectedFunction) {
    String fieldText = '';
    Color textColor;
    if (_currentDate != null) {
      final formatter = DateFormat('dd/MM/yyyy');
      fieldText = formatter.format(_currentDate!);
      textColor = widget.color;
    } else {
      fieldText = hintText;
      textColor = widget.hintColor;
    }

    return Flexible(
      child: GestureDetector(
        onTap: !widget.enabled
            ? null
            : () async {
                if (_currentDate == null) {
                  setState(() {
                    _currentDate = DateTime.now();
                  });
                }
                await showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    if (store.initialDateTime == null) {
                      store.initialDateTime = DateTime.now();
                    } else if (store.finalDateTime == null &&
                        store.initialDateTime != null) {
                      store.finalDateTime = DateTime.now();
                    }
                    return SafeArea(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.45,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Selecione dia, mês e ano.',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0.2,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (DateTime date) {
                                  widget.onDateChange(date);
                                  onSelectedDate(date);
                                },
                                initialDateTime: DateTime.now(),
                                maximumDate: DateTime.now(),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.85,
                              child: GestureDetector(
                                onTap: () async {
                                  store.updateState();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Confirmar',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                callCallback();
              },
        child: InputDecorator(
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: textColor,
                  fontSize: widget.fontSize,
                ),
            contentPadding: EdgeInsets.all(widget.textfieldPadding),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(
                color: Theme.of(context).cardColor,
                width: 0.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(
                color: Theme.of(context).cardColor,
                width: 0.0,
              ),
            ),
            suffixIcon: Icon(
              Icons.calendar_month_sharp,
              color: Theme.of(context).primaryColor.withOpacity(0.75),
              size: 25,
            ),
          ),
          child: Text(
            fieldText,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: textColor,
                  fontSize: widget.fontSize,
                ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildTextField(widget.hintText, onSelectedDate),
      ],
    );
  }
}
