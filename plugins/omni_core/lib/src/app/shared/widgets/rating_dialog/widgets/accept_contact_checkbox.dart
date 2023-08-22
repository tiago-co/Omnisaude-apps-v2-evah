import 'package:flutter/material.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/store/rating_store.dart';

class AcceptContactCheckbox extends StatefulWidget {
  const AcceptContactCheckbox({Key? key, required this.store})
      : super(key: key);
  final RatingStore store;
  @override
  State<AcceptContactCheckbox> createState() => _AcceptContactCheckboxState();
}

class _AcceptContactCheckboxState extends State<AcceptContactCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.store.state.acceptContact,
      onChanged: (bool? value) {
        widget.store.changeCheckBoxValue(value);
        setState(() {});
      },
      activeColor: Theme.of(context).primaryColor,
      checkColor: Theme.of(context).colorScheme.background,
      controlAffinity: ListTileControlAffinity.leading,
      tileColor: Theme.of(context).cardColor.withOpacity(0.05),
      contentPadding: EdgeInsets.zero,
      title: const Text(
        'Podemos entrar em contato para entender melhor a sua experiência?',
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
