import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_date_filter_store.dart';
import 'package:refund_tab_status_labels/labels.dart';

class RefundRequestDateFilterWidget extends StatefulWidget {
  const RefundRequestDateFilterWidget({Key? key}) : super(key: key);

  @override
  State<RefundRequestDateFilterWidget> createState() =>
      _RefundRequestDateFilterWidgetState();
}

class _RefundRequestDateFilterWidgetState
    extends State<RefundRequestDateFilterWidget> {
  final RefundRequestDateFilterStore store = Modular.get();
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _selectedDateTime = null;
        showModalBottomSheet(
          context: context,
          builder: (_) => Container(
            height: 400,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (date) {
                      _selectedDateTime = date;
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    _selectedDateTime ??= DateTime.now();

                    store.isDateSelected = true;
                    store.update(DateUtils.dateOnly(_selectedDateTime!));
                    store.onChangeStatus(store.state);

                    Modular.to.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        RefundTabStatusLabels.refundRequestDateFilterSelect,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
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
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: TripleBuilder<RefundRequestDateFilterStore, Exception, DateTime>(
        store: store,
        builder: (_, triple) {
          return Container(
            decoration: BoxDecoration(
              color: store.isDateSelected
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.filter,
                  package: AssetsPackage.omniGeneral,
                  width: 15,
                  height: 15,
                  color: store.isDateSelected
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  store.isDateSelected
                      ? Formaters.dateToStringDate(triple.state)
                      : RefundTabStatusLabels.refundRequestDateFilterDate,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: store.isDateSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                ),
                if (store.isDateSelected) const SizedBox(width: 10),
                if (store.isDateSelected)
                  GestureDetector(
                    onTap: () {
                      store.isDateSelected = false;
                      store.requestStore.params.requestDate = null;
                      store.requestStore
                          .getAllRefundRequest()
                          .then((value) => store.update(DateTime.now()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        RefundTabStatusLabels.refundRequestDateFilterClean,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
