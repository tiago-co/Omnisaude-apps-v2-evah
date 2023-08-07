import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_item_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shared_labels/labels.dart';

class DynamicFormWidget extends StatefulWidget {
  final Function(String) getFields;
  final Function(AnswerDynamicFormModel)? answerDynamicForm;
  final DynamicFormModel dynamicForm;
  final bool readOnly;

  const DynamicFormWidget({
    Key? key,
    required this.getFields,
    required this.dynamicForm,
    this.answerDynamicForm,
    this.readOnly = false,
  })  : assert(readOnly ? answerDynamicForm == null : !readOnly),
        super(key: key);

  @override
  _DynamicFormWidgetState createState() => _DynamicFormWidgetState();
}

class _DynamicFormWidgetState extends State<DynamicFormWidget> {
  @override
  Widget build(BuildContext context) {
    return VerticalTimelineItemWidget(
      child: GestureDetector(
        onTap: () {
          Helpers.showDialog(
            context,
            DynamicFormItemWidget(
              readOnly: widget.readOnly,
              dynamicForm: widget.dynamicForm,
              answerDynamicForm: widget.answerDynamicForm,
              getFields: () => widget.getFields(widget.dynamicForm.id!),
            ),
            showClose: !widget.readOnly,
          );
        },
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.dynamicForm.createdAt != null)
                Row(
                  children: [
                    Text(
                      Formaters.dateToStringDate(
                        Formaters.stringToDateTime(
                          widget.dynamicForm.createdAt!,
                        ),
                      ),
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(child: SizedBox()),
                    const SizedBox(width: 15),
                    Text(
                      DateFormat('Hm').format(
                        Formaters.stringToDateTime(
                          widget.dynamicForm.createdAt!,
                        ),
                      ),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                          ),
                    ),
                  ],
                ),
              if (widget.dynamicForm.createdAt != null)
                const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Text(
                  widget.dynamicForm.name ?? SharedLabels.dynamicFormNoName,
                  softWrap: false,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
              ),
              if (widget.dynamicForm.createdAt == null) const Divider(),
              if (widget.dynamicForm.createdAt != null)
                const SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Text(
                  widget.dynamicForm.description ?? SharedLabels.dynamicFormNoDescription,
                  softWrap: false,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
