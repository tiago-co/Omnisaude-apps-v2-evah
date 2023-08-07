import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/stores/date_time_picker_store.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimePickerService extends Disposable {
  final DateTimePickerStore store = DateTimePickerStore();
  late DateTime? dateTime;

  Future<DateTime?> selectDate(
    BuildContext context, {
    DateTime? maxDate,
    DateTime? minDate,
    DateTime? initialDisplayDate,
    bool enablePastDates = false,
    Function(DateTime, DateTime)? args,
    List<DateTime> blackoutDates = const [],
    Future<List<DateTime>?> Function(Map<String, dynamic> args)? onChangeView,
  }) async {
    final DateRangePickerController controller = DateRangePickerController();
    store.update(blackoutDates);
    final DateTime now = DateTime.now();
    dateTime = initialDisplayDate;
    bool hasSelected = false;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      isDismissible: false,
      isScrollControlled: true,
      builder: (_) {
        return ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: BottomSheetHeaderWidget(title: 'Escolha a data'),
              ),
              SizedBox(
                height: 350,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: TripleBuilder<DateTimePickerStore, Exception,
                      List<DateTime>>(
                    store: store,
                    builder: (_, triple) {
                      return Opacity(
                        opacity: triple.isLoading ? 0.5 : 1.0,
                        child: AbsorbPointer(
                          absorbing: triple.isLoading,
                          child: _buildDatePickerWidget(
                            context,
                            now,
                            args: args,
                            maxDate: maxDate,
                            minDate: minDate,
                            controller: controller,
                            onChangeView: onChangeView,
                            blackoutDates: triple.state,
                            enablePastDates: enablePastDates,
                            initialDisplayDate: initialDisplayDate,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              TripleBuilder(
                store: store,
                builder: (_, triple) {
                  return BottomButtonWidget(
                    onPressed: () {
                      dateTime ??= now;
                      hasSelected = true;
                      Modular.to.pop();
                    },
                    isDisabled: store.isDisabled,
                    isLoading: triple.isLoading,
                    text: 'Confirmar',
                    buttonType: BottomButtonType.outline,
                  );
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      store.canRequest = false;
      store.dateTime = null;
    });

    if (!hasSelected) dateTime = null;
    return dateTime;
  }

  Future<DateTime?> selectTime(
    BuildContext context, {
    DateTime? initialDateTime,
    DateTime? minimumDate,
  }) async {
    final DateTime now = DateTime.now();
    dateTime = initialDateTime ?? now;
    bool hasSelected = false;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      isDismissible: false,
      builder: (_) {
        return ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: BottomSheetHeaderWidget(title: 'Escolha o horário'),
              ),
              SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: Brightness.dark,
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.black,
                              ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (DateTime newDateTime) {
                      dateTime = newDateTime;
                    },
                    minimumDate: minimumDate,
                    initialDateTime: initialDateTime ?? now,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                  ),
                ),
              ),
              BottomButtonWidget(
                onPressed: () {
                  dateTime ??= now;
                  hasSelected = true;
                  Modular.to.pop();
                },
                text: 'Confirmar',
                buttonType: BottomButtonType.outline,
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      store.canRequest = false;
      store.dateTime = null;
    });

    if (!hasSelected) dateTime = null;
    return dateTime;
  }

  Widget _buildDatePickerWidget(
    BuildContext context,
    DateTime now, {
    DateTime? maxDate,
    DateTime? minDate,
    DateTime? initialDisplayDate,
    bool enablePastDates = false,
    Function(DateTime, DateTime)? args,
    DateRangePickerController? controller,
    List<DateTime> blackoutDates = const [],
    Future<List<DateTime>?> Function(Map<String, dynamic> args)? onChangeView,
  }) {
    return SfDateRangePicker(
      initialDisplayDate: initialDisplayDate,
      toggleDaySelection: true,
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      controller: controller,
      minDate: minDate,
      maxDate: maxDate,
      showNavigationArrow: true,
      enablePastDates: enablePastDates,
      monthViewSettings: _monthViewSettings(context, blackoutDates),
      onViewChanged: (DateRangePickerViewChangedArgs dateArgs) async {
        if (onChangeView == null || args == null) return;
        final Map<String, dynamic> args0 = args(
          dateArgs.visibleDateRange.startDate ?? now,
          dateArgs.visibleDateRange.endDate ?? now,
        );
        store.getBlackoutDates(args0, onChangeView);
      },
      todayHighlightColor: Theme.of(context).primaryColor,
      selectionShape: DateRangePickerSelectionShape.rectangle,
      selectionColor: Theme.of(context).primaryColor,
      rangeTextStyle: Theme.of(context).textTheme.headlineMedium,
      yearCellStyle: _yearCellStyle(context),
      monthCellStyle: _monthCellStyle(context),
      headerStyle: DateRangePickerHeaderStyle(
        textStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      selectionTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        dateTime = args.value;
        store.updateDateTime(dateTime);
      },
    );
  }

  @override
  void dispose() {
    store.destroy();
  }
}

DateRangePickerMonthViewSettings _monthViewSettings(
  BuildContext context,
  List<DateTime> blackoutDates,
) {
  return DateRangePickerMonthViewSettings(
    blackoutDates: blackoutDates,
    weekNumberStyle: DateRangePickerWeekNumberStyle(
      textStyle: TextStyle(color: Theme.of(context).primaryColor),
    ),
    viewHeaderStyle: DateRangePickerViewHeaderStyle(
      textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 10,
            color: Theme.of(context)
                .textTheme
                .titleLarge!
                .color!
                .withOpacity(0.75),
          ),
    ),
  );
}

DateRangePickerYearCellStyle _yearCellStyle(BuildContext context) {
  return DateRangePickerYearCellStyle(
    textStyle: Theme.of(context).textTheme.titleLarge,
    todayTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).primaryColor,
        ),
    leadingDatesTextStyle: Theme.of(context).textTheme.titleLarge,
    disabledDatesTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color:
              Theme.of(context).textTheme.titleLarge!.color!.withOpacity(0.25),
        ),
  );
}

DateRangePickerMonthCellStyle _monthCellStyle(BuildContext context) {
  return DateRangePickerMonthCellStyle(
    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.black,
        ),
    disabledDatesTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(
                0.5,
              ),
        ),
    blackoutDateTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(
                0.5,
              ),
          decoration: TextDecoration.lineThrough,
        ),
    todayTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).primaryColor,
        ),
    weekendTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.red.withOpacity(0.9),
          fontWeight: FontWeight.w600,
        ),
  );
}
