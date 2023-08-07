import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/procedure_enum.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedure_details_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:procedures_labels/labels.dart';

class RefuseProcedureItemWidget extends StatefulWidget {
  final ProcedureModel procedure;

  const RefuseProcedureItemWidget({
    Key? key,
    required this.procedure,
  }) : super(key: key);

  @override
  _RefuseProcedureItemWidgetState createState() =>
      _RefuseProcedureItemWidgetState();
}

class _RefuseProcedureItemWidgetState extends State<RefuseProcedureItemWidget> {
  final ProcedureDetailsStore store = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void disapproveProdecure() {
    final Map<String, String> data = {
      'status': ProcedureStatus.disapproved.toJson!,
    };
    store.updateProcedure(widget.procedure.id!, data).then((value) {
      Modular.to.pop();
    }).catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          error: onError,
          onPressed: () => Modular.to.pop(),
          buttonText: ProceduresLabels.close,
        ),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom >= 60
                ? MediaQuery.of(context).viewInsets.bottom - 60
                : 0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BottomSheetHeaderWidget(
                title:  ProceduresLabels.refuseProcedureItemReject,
              ),
              _buildRefuseReasonFormWidget,
            ],
          ),
        ),
        const SizedBox(height: 5),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: disapproveProdecure,
              isLoading: triple.isLoading,
              isDisabled: store.isDisabled,
              buttonType: BottomButtonType.outline,
              text: ProceduresLabels.refuseProcedureItemReject,
            );
          },
        ),
      ],
    );
  }

  Widget get _buildRefuseReasonFormWidget {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return AbsorbPointer(
          absorbing: triple.isLoading,
          child: Opacity(
            opacity: triple.isLoading ? 0.5 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFieldWidget(
                  controller: textController,
                  label: ProceduresLabels.refuseProcedureItemRejectReasonLabel,
                  placeholder: ProceduresLabels.refuseProcedureItemRejectReasonPlaceholder,
                  onChange: store.onChangeTextFieldValue,
                  suffixIcon: const Icon(Icons.description_outlined),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
