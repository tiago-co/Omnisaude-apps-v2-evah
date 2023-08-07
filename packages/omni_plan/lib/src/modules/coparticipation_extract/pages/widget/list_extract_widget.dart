// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/coparticipation_extract_model.dart';
import 'package:omni_plan/src/core/models/extract_beneficiary_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/date_extract_list_widget.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/coparticipation_extract_store.dart';

class ListExtractWidget extends StatefulWidget {
  final List<DateExtract> dateExtracts;
  const ListExtractWidget({
    Key? key,
    required this.dateExtracts,
  }) : super(key: key);

  @override
  State<ListExtractWidget> createState() => _ListExtractWidgetState();
}

class _ListExtractWidgetState extends State<ListExtractWidget> {
  CoparticipationExtractStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TripleBuilder<CoparticipationExtractStore, DioError,
            ExtractBeneficiaryModel>(
          store: store,
          builder: (_, state) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.dateExtracts.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.dateExtracts[index].date}',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    DateExtractListWidget(
                      dateExtract: widget.dateExtracts[index],
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
