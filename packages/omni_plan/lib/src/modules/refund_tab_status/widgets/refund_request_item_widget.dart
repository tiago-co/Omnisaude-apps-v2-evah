import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/enums/requisition_status_enum.dart';
import 'package:omni_plan/src/core/models/refund_request_model.dart';
import 'package:refund_tab_status_labels/labels.dart';

class RefundRequestItemWidget extends StatelessWidget {
  final RefundRequestModel refundRequest;
  const RefundRequestItemWidget({
    Key? key,
    required this.refundRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(
        'refund_request_items',
        arguments: refundRequest,
      ),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Theme.of(context).cardColor.withOpacity(0.25),
            ),
          ),
          color: refundRequest.requisitionStatus!.color,
          child: Container(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  RefundTabStatusLabels.refundRequestItemRequestSequenceNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${refundRequest.requestSequenceNumber}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              RefundTabStatusLabels.refundRequestItemRequestRequestDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              Formaters.dateToStringDate(
                                Formaters.stringToDate(
                                  refundRequest.requestDate!,
                                ),
                              ),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: RefundTabStatusLabels.refundRequestItemRequestRequisitionStatus,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: refundRequest
                                          .requisitionStatus!.label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.arrowRight,
                    package: AssetsPackage.omniGeneral,
                    color: Theme.of(context).cardColor,
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
