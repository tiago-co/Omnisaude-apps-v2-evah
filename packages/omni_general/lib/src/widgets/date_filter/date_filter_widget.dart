import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart' show Formaters;
import 'package:omni_general/src/core/enums/date_filter_mode_enum.dart';
import 'package:omni_general_labels/labels.dart';

class DateFilterWidget extends StatelessWidget {
  final VoidCallback? previousMonth;
  final VoidCallback? nextMonth;
  final bool isLoading;
  final DateTime date;
  final DateFilterMode mode;

  const DateFilterWidget({
    Key? key,
    this.previousMonth,
    this.nextMonth,
    this.mode = DateFilterMode.monthYear,
    required this.date,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildDateModeWidget(context)),
        const SizedBox(width: 10),
        Row(
          children: [
            GestureDetector(
              onTap: isLoading ? null : previousMonth,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(
                          isLoading ? 0.5 : 1.0,
                        ),
                    width: 0.5,
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                padding: const EdgeInsets.fromLTRB(15, 15, 17.5, 15),
                child: SvgPicture.asset(
                  Assets.arrowLeft,
                  color: Theme.of(context).primaryColor.withOpacity(
                        isLoading ? 0.5 : 1.0,
                      ),
                  height: 15,
                  package: AssetsPackage.omniGeneral,
                ),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: isLoading ? null : nextMonth,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(
                          isLoading ? 0.5 : 1.0,
                        ),
                    width: 0.5,
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                padding: const EdgeInsets.fromLTRB(17.5, 15, 15, 15),
                child: SvgPicture.asset(
                  Assets.arrowRight,
                  color: Theme.of(context).primaryColor.withOpacity(
                        isLoading ? 0.5 : 1.0,
                      ),
                  height: 15,
                  package: AssetsPackage.omniGeneral,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateModeWidget(BuildContext context) {
    switch (mode) {
      case DateFilterMode.year:
        return Text(
          '${date.year}',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        );
      case DateFilterMode.month:
        return Text(
          Formaters.capitalize(DateFormat('MMMM', 'pt_BR').format(date)),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        );
      case DateFilterMode.day:
        return Text(
          Formaters.capitalize(DateFormat('DD', 'pt_BR').format(date)),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        );
      case DateFilterMode.monthYear:
        return Text(
          '${Formaters.capitalize(DateFormat('MMMM', 'pt_BR').format(date))},'
          ' ${date.year}',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        );
      case DateFilterMode.dayMonthYear:
        return Text(
          '${date.day} ${GeneralLabels.dateFilterOf} '
          '${Formaters.capitalize(DateFormat('MMMM', 'pt_BR').format(date))},'
          ' ${date.year}',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        );
      case DateFilterMode.dayMonth:
        return Text(
          '${date.day} ${GeneralLabels.dateFilterOf} '
          '${Formaters.capitalize(DateFormat('MMMM', 'pt_BR').format(date))}',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        );
    }
  }
}
