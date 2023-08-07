import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/stores/assistances_store.dart';
import 'package:omni_assistance/src/assistance/widgets/assistance_status_filter_widget.dart';

class AssistanceGeneralFiltersWidget extends StatefulWidget {
  const AssistanceGeneralFiltersWidget({Key? key}) : super(key: key);

  @override
  State<AssistanceGeneralFiltersWidget> createState() =>
      _AssistanceGeneralFiltersWidgetState();
}

class _AssistanceGeneralFiltersWidgetState
    extends State<AssistanceGeneralFiltersWidget> {
  final AssistancesStore assistancesStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: assistancesStore,
      builder: (_, triple) {
        return AbsorbPointer(
          absorbing: triple.isLoading,
          child: Opacity(
            opacity: triple.isLoading ? 0.5 : 1.0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  AssistanceStatusFilterWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
