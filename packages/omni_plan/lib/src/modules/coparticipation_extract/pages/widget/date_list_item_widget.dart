// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:omni_plan/src/core/models/coparticipation_extract_model.dart';

class DateListItemWidget extends StatefulWidget {
  final CoparticipationExtractModel extractBeneficiary;
  const DateListItemWidget({
    Key? key,
    required this.extractBeneficiary,
  }) : super(key: key);

  @override
  State<DateListItemWidget> createState() => _DateListItemWidgetState();
}

class _DateListItemWidgetState extends State<DateListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${widget.extractBeneficiary.dsItem}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '${widget.extractBeneficiary.dsTipoItem}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    'R\$ ${widget.extractBeneficiary.vlCoparticipacao!.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
