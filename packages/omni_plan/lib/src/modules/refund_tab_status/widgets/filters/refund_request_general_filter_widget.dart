import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_store.dart';
import 'package:omni_plan/src/modules/refund_tab_status/widgets/filters/refund_request_date_filter_widget.dart';
import 'package:omni_plan/src/modules/refund_tab_status/widgets/filters/refund_request_status_filter_widget.dart';

class RefundRequestGeneralFilterWidget extends StatefulWidget {
  const RefundRequestGeneralFilterWidget({Key? key}) : super(key: key);

  @override
  State<RefundRequestGeneralFilterWidget> createState() =>
      _RefundRequestGeneralFilterWidgetState();
}

class _RefundRequestGeneralFilterWidgetState
    extends State<RefundRequestGeneralFilterWidget> {
  final RefundRequestStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
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
                  RefundRequestStatusFilterWidget(),
                  SizedBox(width: 10),
                  RefundRequestDateFilterWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
