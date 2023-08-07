import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/stores/assistance_store.dart';
import 'package:omni_assistance/src/core/models/assistance_model.dart';
import 'package:omni_assistance_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class CreateAssistancePage extends StatefulWidget {
  const CreateAssistancePage({Key? key}) : super(key: key);

  @override
  State<CreateAssistancePage> createState() => _CreateAssistancePageState();
}

class _CreateAssistancePageState extends State<CreateAssistancePage> {
  final AssistanceStore store = Modular.get();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  final FocusNode subjectNode = FocusNode();
  final FocusNode noteNode = FocusNode();
  final FocusNode contactNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const NavBarWidget(
        title: AssistanceLabels.createAssistanceTitle,
      ).build(context) as AppBar,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[
              TextFieldWidget(
                label: AssistanceLabels.createAssistanceSubjectLabel,
                controller: subjectController,
                focusNode: subjectNode,
                onSubmitted: (input) {
                  Helpers.changeFocus(context, subjectNode, contactNode);
                },
                onChange: (String? input) {
                  store.state.subject = input;
                  store.update(store.state);
                },
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
                    return AssistanceLabels.createAssistanceEmptyField;
                  }
                  return null;
                },
              ),
              TextFieldWidget(
                label: AssistanceLabels.createAssistanceContactLabel,
                controller: contactController,
                focusNode: contactNode,
                onSubmitted: (input) {
                  Helpers.changeFocus(context, subjectNode, noteNode);
                },
                onChange: (String? input) {
                  store.state.contact = input;
                  store.update(store.state);
                },
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
                    return AssistanceLabels.createAssistanceEmptyField;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                focusNode: noteNode,
                onChanged: (String? input) {
                  store.state.note = input;
                  store.update(store.state);
                },
                onFieldSubmitted: (input) {
                  if (_formKey.currentState!.validate()) {
                    store.createAssistance();
                  }
                },
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
                    return AssistanceLabels.createAssistanceEmptyField;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: AssistanceLabels.createAssistanceObservation,
                  labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor.withOpacity(0.75),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor.withOpacity(0.75),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor.withOpacity(0.75),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor.withOpacity(0.75),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    store.createAssistance().whenComplete(
                          () => Modular.to.pop(),
                        );
                  }
                },
                child:
                    TripleBuilder<AssistanceStore, DioError, AssistanceModel>(
                  store: store,
                  builder: (_, triple) {
                    if (triple.isLoading) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 1),
                          child: LoadingWidget(
                            isStretch: true,
                            indicatorColor: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Text(
                          AssistanceLabels.createAssistanceSend,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
