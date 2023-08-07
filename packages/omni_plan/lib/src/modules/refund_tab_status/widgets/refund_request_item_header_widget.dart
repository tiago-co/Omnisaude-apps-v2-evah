import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/enums/requisition_status_enum.dart';
import 'package:omni_plan/src/core/models/refund_request_model.dart';
import 'package:refund_tab_status_labels/labels.dart';

class RefundRequestItemHeaderWidget extends StatelessWidget {
  final RefundRequestModel refundRequest;
  const RefundRequestItemHeaderWidget({
    Key? key,
    required this.refundRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: refundRequest.requisitionStatus!.color!.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    RefundTabStatusLabels.refundRequestItemHeaderRequestSequenceNumber,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    refundRequest.requestSequenceNumber!,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    RefundTabStatusLabels.refundRequestItemHeaderRequestDate,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: Theme.of(context).cardColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        Formaters.dateToStringDate(
                          Formaters.stringToDate(refundRequest.requestDate!),
                        ),
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 30,
            thickness: 1,
            color: Colors.grey.shade400,
          ),
          Column(
            children: [
              Text(
                RefundTabStatusLabels.refundRequestItemHeaderRequisitionStatus,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (refundRequest.requisitionStatus! == RequisitionStatus.denied)
                Text(
                  RefundTabStatusLabels.refundRequestItemHeaderDenied,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                )
              else
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: refundRequest.requisitionStatus!.color,
                  ),
                  child: Text(
                    refundRequest.requisitionStatus!.label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
