import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/stores/assistance_store.dart';
import 'package:omni_assistance/src/core/enums/assistance_status_enum.dart';
import 'package:omni_assistance/src/core/models/assistance_model.dart';
import 'package:omni_assistance_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class AssistanceDetailsPage extends StatefulWidget {
  final AssistanceModel assistance;
  const AssistanceDetailsPage({
    Key? key,
    required this.assistance,
  }) : super(key: key);

  @override
  State<AssistanceDetailsPage> createState() => _AssistanceDetailsState();
}

class _AssistanceDetailsState extends State<AssistanceDetailsPage> {
  final AssistanceStore store = Modular.get();
  @override
  void initState() {
    store.getAssistance(widget.assistance.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.assistance.subject!).build(context)
          as AppBar,
      body: TripleBuilder<AssistanceStore, DioError, AssistanceModel>(
        store: store,
        builder: (_, triple) {
          if (store.isLoading) {
            return const LoadingWidget();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DetailsItemWidget(
                      label: AssistanceLabels.assistanceDetailsSubject,
                      value: store.state.subject ?? 'N/A',
                    ),
                    const Divider(),
                    DetailsItemWidget(
                      label: AssistanceLabels.assistanceDetailsStatus,
                      value: store.state.status?.label ?? 'N/A',
                    ),
                    const Divider(),
                    DetailsItemWidget(
                      label: AssistanceLabels.assistanceDetailsNote,
                      value: store.state.note ?? 'N/A',
                    ),
                    const Divider(),
                    DetailsItemWidget(
                      label: AssistanceLabels.assistanceDetailsContact,
                      value: store.state.contact ?? 'N/A',
                    ),
                    const Divider(),
                    DetailsItemWidget(
                      label: AssistanceLabels.assistanceDetailsServiceObservation,
                      value: store.state.serviceObservation != ''
                          ? store.state.serviceObservation
                          : 'N/A',
                    ),
                    const Divider(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
