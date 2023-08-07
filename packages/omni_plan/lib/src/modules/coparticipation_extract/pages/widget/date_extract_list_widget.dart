// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/coparticipation_extract_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/date_list_item_widget.dart';

class DateExtractListWidget extends StatefulWidget {
  final DateExtract dateExtract;
  const DateExtractListWidget({
    Key? key,
    required this.dateExtract,
  }) : super(key: key);

  @override
  State<DateExtractListWidget> createState() => _DateExtractListWidgetState();
}

class _DateExtractListWidgetState extends State<DateExtractListWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.dateExtract.listExtract!.length,
          itemBuilder: (_, index) {
            return VerticalTimelineItemWidget(
              child: InkWell(
                onTap: () {
                  Modular.to.pushNamed(
                    'details_item',
                    arguments:
                        widget.dateExtract.listExtract![index].idExtratoCopart,
                  );
                },
                child: DateListItemWidget(
                  extractBeneficiary: widget.dateExtract.listExtract![index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
