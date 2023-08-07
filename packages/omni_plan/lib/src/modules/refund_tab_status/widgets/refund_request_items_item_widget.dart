import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/enums/item_status_requisition_enum.dart';
import 'package:omni_plan/src/core/models/refund_request_item_model.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_items_store.dart';
import 'package:refund_tab_status_labels/labels.dart';

class RefundRequestItemsItemWidget extends StatefulWidget {
  final RefundRequestItemModel refundRequestItem;
  const RefundRequestItemsItemWidget({
    Key? key,
    required this.refundRequestItem,
  }) : super(key: key);

  @override
  State<RefundRequestItemsItemWidget> createState() =>
      _RefundRequestItemsItemWidgetState();
}

class _RefundRequestItemsItemWidgetState
    extends State<RefundRequestItemsItemWidget>
    with SingleTickerProviderStateMixin {
  final RefundRequestItemsStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 5,
              left: 5,
              bottom: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            RefundTabStatusLabels.refundRequestItemsItemCode,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.refundRequestItem.itemCode ?? '-',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.refundRequestItem.requestDate != null
                                  ? Formaters.dateToStringDate(
                                      Formaters.stringToDate(
                                        widget.refundRequestItem.requestDate!,
                                      ),
                                    )
                                  : '-',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        RefundTabStatusLabels.refundRequestItemsItemDescription,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.refundRequestItem.itemDescription ?? '-',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            RefundTabStatusLabels.refundRequestItemsItemRequestedQuantity,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            widget.refundRequestItem.requestedQuantity != null
                                ? widget.refundRequestItem.requestedQuantity!
                                    .toString()
                                : '-',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            RefundTabStatusLabels.refundRequestItemsItemReleasedQuantity,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            widget.refundRequestItem.releasedQuantity != null
                                ? widget.refundRequestItem.releasedQuantity!
                                    .toString()
                                : '-',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                          RefundTabStatusLabels.refundRequestItemsItemStatus,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            widget.refundRequestItem.itemStatusDescription !=
                                    null
                                ? widget.refundRequestItem
                                    .itemStatusDescription!.label
                                : '-',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: widget.refundRequestItem
                                      .itemStatusDescription!.color,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      if (widget.refundRequestItem.denialReasonDescription !=
                              null &&
                          widget.refundRequestItem.denialReasonDescription!
                              .isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(height: 40),
                            Text(
                              RefundTabStatusLabels.refundRequestItemsItemDenialReason,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.refundRequestItem.denialReasonDescription!,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
