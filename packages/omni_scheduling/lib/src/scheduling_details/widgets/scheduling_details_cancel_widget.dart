import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_cancel_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsCancelWidget extends StatefulWidget {
  final String schedulingId;

  const SchedulingDetailsCancelWidget({
    Key? key,
    required this.schedulingId,
  }) : super(key: key);

  @override
  _SchedulingDetailsCancelWidgetState createState() =>
      _SchedulingDetailsCancelWidgetState();
}

class _SchedulingDetailsCancelWidgetState
    extends State<SchedulingDetailsCancelWidget> {
  final SchedulingDetailsCancelStore store = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void cancelScheduling() {
    final Map<String, String> data = {
      'acao': 'cancelar',
      'razao_cancelamento': textController.text.trim(),
    };
    store.cancelScheduling(widget.schedulingId, data).then((value) async {
      Modular.to.pop();
      await Helpers.showDialog(
        context,
        SuccessWidget(
          message: SchedulingLabels.schedulingDetailsCancelSuccess,
          onPressed: () {
            Modular.to.pop();
          },
        ),
      );
    }).catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          error: onError,
          buttonText: SchedulingLabels.close,
          onPressed: () => Modular.to.pop(),
        ),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom >= 60
                      ? MediaQuery.of(context).viewInsets.bottom - 60
                      : 0,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BottomSheetHeaderWidget(
                      title:
                          SchedulingLabels.schedulingDetailsCancelAppointment,
                    ),
                    TripleBuilder(
                      store: store,
                      builder: (_, triple) {
                        return AbsorbPointer(
                          absorbing: triple.isLoading,
                          child: Opacity(
                            opacity: triple.isLoading ? 0.5 : 1.0,
                            child: TextFieldWidget(
                              label: SchedulingLabels
                                  .schedulingDetailsCancelReasonLabel,
                              placeholder: SchedulingLabels
                                  .schedulingDetailsCancelReasonPlaceholder,
                              controller: textController,
                              suffixIcon: const Icon(
                                Icons.description_outlined,
                              ),
                              onChange: (String? input) {
                                store.update(input ?? '');
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            TripleBuilder(
              store: store,
              builder: (_, triple) {
                return Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.red),
                  child: BottomButtonWidget(
                    onPressed: cancelScheduling,
                    isLoading: triple.isLoading,
                    isDisabled: store.isDisabled,
                    text: SchedulingLabels.cancel,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
