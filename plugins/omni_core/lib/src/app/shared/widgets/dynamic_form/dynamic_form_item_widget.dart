import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/dynamic_form_field_enum.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_field_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_field_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/stores/dynamic_form_item_store.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_input_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_select_widget.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_upload_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shared_labels/labels.dart';

class DynamicFormItemWidget extends StatefulWidget {
  final bool readOnly;
  final Function getFields;
  final DynamicFormModel dynamicForm;
  final Function(AnswerDynamicFormModel)? answerDynamicForm;

  const DynamicFormItemWidget({
    Key? key,
    this.readOnly = false,
    this.answerDynamicForm,
    required this.getFields,
    required this.dynamicForm,
  })  : assert(readOnly ? answerDynamicForm == null : !readOnly),
        super(key: key);

  @override
  _DynamicFormItemWidgetState createState() => _DynamicFormItemWidgetState();
}

class _DynamicFormItemWidgetState extends State<DynamicFormItemWidget> {
  final DynamicFormItemStore store = DynamicFormItemStore();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    store.getFields(widget.getFields);
    super.initState();
  }

  @override
  void dispose() {
    store.destroy();
    super.dispose();
  }

  void answerDynamicForm() {
    if (widget.readOnly) {
      Modular.to.pop();
      return;
    }
    if (!formKey.currentState!.validate()) return;
    store
        .answerDynamicForm(widget.answerDynamicForm!, store.answerForm)
        .then((value) {
      Helpers.showDialog(
        context,
        SuccessWidget(
          message: SharedLabels.dynamicFormItemSuccess,
          onPressed: () => Modular.to.pop(),
        ),
      );
    }).catchError(
      (onError) {
        Helpers.showDialog(
          context,
          RequestErrorWidget(
            error: onError,
            buttonText: SharedLabels.close,
            onPressed: () => Modular.to.pop(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.dynamicForm.name ?? SharedLabels.dynamicFormItemNoName,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                  shadowColor: Colors.transparent,
                ),
                child: RefreshIndicator(
                  displacement: 0,
                  strokeWidth: 0.75,
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () async {
                    store.getFields(widget.getFields);
                  },
                  child: _buildFieldListWidget,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            onPressed: answerDynamicForm,
            buttonType: widget.readOnly
                ? BottomButtonType.outline
                : BottomButtonType.primary,
            text: widget.readOnly
                ? SharedLabels.dynamicFormItemClose
                : SharedLabels.dynamicFormItemSave,
            isBottomSafe: false,
          );
        },
      ),
    );
  }

  Widget get _buildFieldListWidget {
    return TripleBuilder<DynamicFormItemStore, DioError, DynamicFormModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return const DynamicFormFieldShimmerWidget();
        }
        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () {
                        store.getFields(widget.getFields);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            if (triple.state.fields!.isEmpty && !triple.isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: EmptyWidget(
                    message: SharedLabels.dynamicFormItemEmpty,
                    textButton: SharedLabels.dynamicFormItemTryAgain,
                    onPressed: () => store.getFields(widget.getFields),
                  ),
                ),
              ),
            if (triple.state.fields!.isNotEmpty)
              Form(
                key: formKey,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: triple.state.fields!.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemBuilder: (_, index) {
                    return _buildFieldItemWidget(triple.state.fields![index]);
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFieldItemWidget(DynamicFormFieldModel field) {
    final List<FieldModel> formFields = List.from(store.answerForm.fields);
    switch (field.type) {
      case DynamicFormType.input:
        final int indexOf = formFields.indexWhere((obj) => obj.id == field.id);
        return DynamicInputWidget(
          input: field.inputField!,
          readOnly: widget.readOnly,
          onChangeAnswer: widget.readOnly
              ? null
              : (String? answer) {
                  formFields[indexOf].value = answer ?? '';
                },
        );
      case DynamicFormType.upload:
        return DynamicUploadWidget(
          upload: field.uploadField!,
          readOnly: widget.readOnly,
        );
      case DynamicFormType.select:
        final int indexOf = formFields.indexWhere((obj) => obj.id == field.id);
        return DynamicSelectWidget(
          select: field.selectField!,
          readOnly: widget.readOnly,
          onChangeAnswer: widget.readOnly
              ? null
              : (String? answer) {
                  formFields[indexOf].value = answer ?? '';
                },
        );
      default:
        return const SizedBox();
    }
  }
}
