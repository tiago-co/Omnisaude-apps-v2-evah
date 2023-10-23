import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:omni_general/src/core/utils/formaters.dart';

class BirthDateDialog extends StatefulWidget {
  const BirthDateDialog({Key? key}) : super(key: key);

  @override
  State<BirthDateDialog> createState() => _BirthDateDialogState();
}

class _BirthDateDialogState extends State<BirthDateDialog> {
  bool calendarMode = true;
  TextEditingController inputController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isValidAcceptableDate(DateTime? date) {
    return date != null && !date.isBefore(DateTime(1900)) && !date.isAfter(DateTime.now());
  }

  String? _validateDate(String? text) {
    try {
      if (text != null && text.length == 10) {
        final date = DateFormat('dd/MM/yyyy', 'pt-BR').parseStrict(inputController.text);
        if (!_isValidAcceptableDate(date)) {
          return 'Insira uma data válida!';
        }
      } else {
        return 'Campo obrigatório!';
      }
      return null;
    } catch (e) {
      return 'Insira uma data válida';
    }
  }

  @override
  void initState() {
    super.initState();
    inputController.text = Formaters.dateToStringDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: calendarMode
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Theme(
                  data: ThemeData.light().copyWith(
                    shadowColor: Colors.transparent,
                    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    colorScheme: ColorScheme.light(
                      primary: Theme.of(context).primaryColor,
                      // secondary: Theme.of(context).scaffoldBackgroundColor,
                      // surface: Colors.white,
                    ),
                  ),
                  child: DatePickerDialog(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    onDatePickerModeChange: (mode) {
                      if (mode == DatePickerEntryMode.calendar) {
                        setState(() {
                          calendarMode = true;
                        });
                      } else {
                        setState(() {
                          calendarMode = false;
                        });
                      }
                    },
                  ),
                ),
              ],
            )
          : Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 125,
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 24,
                          end: 12,
                          bottom: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 16),
                            Text(
                              'SELECIONE A DATA',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            const Flexible(child: SizedBox(height: 38)),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    inputFormatters: [MaskTextInputFormatter(mask: '##/##/####')],
                                    validator: _validateDate,
                                    keyboardType: TextInputType.datetime,
                                    autofocus: true,
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                    ),
                                    controller: inputController,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  iconSize: 28,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  onPressed: () => setState(() {
                                    calendarMode = true;
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: TextFormField(
                      inputFormatters: [MaskTextInputFormatter(mask: '##/##/####')],
                      decoration: const InputDecoration(
                        hintText: 'dd/mm/aaaa',
                        labelText: 'Inserir data',
                      ),
                      validator: _validateDate,
                      keyboardType: TextInputType.datetime,
                      autofocus: true,
                      controller: inputController,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OverflowBar(
                          spacing: 8,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'CANCELAR',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  final date = DateFormat('dd/MM/yyyy').parseStrict(inputController.text);
                                  Navigator.of(context).pop(date);
                                }
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
