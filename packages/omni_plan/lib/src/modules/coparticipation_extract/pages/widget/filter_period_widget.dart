import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:coparticipation_extract_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/extract_beneficiary_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/coparticipation_extract_store.dart';

class FilterPeriodWidget extends StatefulWidget {
  const FilterPeriodWidget({Key? key}) : super(key: key);

  @override
  State<FilterPeriodWidget> createState() => _FilterPeriodWidgetState();
}

class _FilterPeriodWidgetState extends State<FilterPeriodWidget> {
  CoparticipationExtractStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<CoparticipationExtractStore, Exception,
        ExtractBeneficiaryModel>(
      store: store,
      builder: (_, duple) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.calendarCheck,
                  package: AssetsPackage.omniCore,
                  color: Theme.of(context).primaryColor,
                  height: 30,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Labels.filterPeriodLabel,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '${Formaters.dateToStringDate(store.initialDateTime!)} á '
                      '${Formaters.dateToStringDate(store.finalDateTime!)}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                final config = CalendarDatePicker2WithActionButtonsConfig(
                  calendarType: CalendarDatePicker2Type.range,
                  currentDate: DateTime.now(),
                  selectedDayHighlightColor: Theme.of(context).primaryColor,
                  // shouldCloseDialogAfterCancelTapped: true,
                  cancelButton: Text(
                    Labels.filterPeriodCancel,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  okButton: Text(
                    Labels.filterPeriodFilter,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  controlsTextStyle:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                  dayTextStyle:
                      Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                  weekdayLabelTextStyle:
                      Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                  lastDate: DateTime.now(),
                  selectedDayTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                );
                final values = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: config,
                  dialogSize: Size(
                    MediaQuery.of(context).size.width * 0.85,
                    MediaQuery.of(context).size.width * 0.1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  initialValue: [],
                  dialogBackgroundColor: Colors.white,
                );
                if (values != null && values.length == 2) {
                  store.initialDateTime = values.first;
                  store.finalDateTime = values.last;
                  await store.getExtractBeneficiary();
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.filter,
                    package: AssetsPackage.omniGeneral,
                    width: 22.5,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    Labels.filterPeriodFilter,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
