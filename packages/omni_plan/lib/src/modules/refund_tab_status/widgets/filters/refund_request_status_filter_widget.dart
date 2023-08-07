import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/enums/requisition_status_enum.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_status_filter_store.dart';
import 'package:refund_tab_status_labels/labels.dart';

class RefundRequestStatusFilterWidget extends StatefulWidget {
  const RefundRequestStatusFilterWidget({Key? key}) : super(key: key);

  @override
  State<RefundRequestStatusFilterWidget> createState() =>
      _RefundRequestStatusFilterWidgetState();
}

class _RefundRequestStatusFilterWidgetState
    extends State<RefundRequestStatusFilterWidget> {
  final RefundRequestStatusFilterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          enableDrag: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: (_) => _buildStatusSheetWidget(_),
        );
      },
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: TripleBuilder<RefundRequestStatusFilterStore, Exception,
          RequisitionStatus>(
        store: store,
        builder: (_, triple) {
          return Container(
            decoration: BoxDecoration(
              color: triple.state != RequisitionStatus.all
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
                  color: triple.state != RequisitionStatus.all
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  triple.state != RequisitionStatus.all
                      ? triple.state.label
                      : RefundTabStatusLabels.refundRequestStatusFilterStatus,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: triple.state != RequisitionStatus.all
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                ),
                if (triple.state != RequisitionStatus.all)
                  const SizedBox(width: 10),
                if (triple.state != RequisitionStatus.all)
                  GestureDetector(
                    onTap: () {
                      store.onChangeStatus(RequisitionStatus.all);
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
                        RefundTabStatusLabels.refundRequestStatusFilterClean,
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

  Widget _buildStatusSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHeaderWidget(
                  title: RefundTabStatusLabels.refundRequestStatusFilterStatus),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: RequisitionStatus.values.length,
                  itemBuilder: (_, index) {
                    return _buildRadioItemWidget(
                      RequisitionStatus.values[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioItemWidget(RequisitionStatus status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RadioListTile<RequisitionStatus>(
        value: status,
        groupValue: store.state,
        onChanged: (RequisitionStatus? status) async {
          log('status: $status');
          store.onChangeStatus(status!);
          Modular.to.pop();
        },
        dense: true,
        activeColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.zero,
        title: Text(
          status.label,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
