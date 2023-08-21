import 'package:flutter/material.dart';
import 'package:omni_assistance_labels/labels.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/store/rating_store.dart';

class DescriptionField extends StatelessWidget {
  DescriptionField({Key? key, required this.store}) : super(key: key);
  final TextEditingController description = TextEditingController();
  final RatingStore store;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      controller: description,
      autofocus: true,
      onChanged: (String? input) {
        store.changeDescription(input);
      },
      validator: (String? input) {
        if (input == null || input.isEmpty) {
          return AssistanceLabels.createAssistanceEmptyField;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Descrição',
        hintText: 'Conte-nos o porquê desta nota...',
        hintStyle: Theme.of(context).textTheme.titleLarge,
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
      ),
    );
  }
}
