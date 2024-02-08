import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_general/omni_general.dart'
    show Helpers, Masks, SelectFieldWidget, TextFieldWidget, RelationshipType, RelationshipTypeExtension;
import 'package:omni_register_labels/labels.dart';

class ResponsableDataFormWidget extends StatefulWidget {
  const ResponsableDataFormWidget({Key? key}) : super(key: key);

  @override
  _ResponsableDataFormWidgetState createState() => _ResponsableDataFormWidgetState();
}

class _ResponsableDataFormWidgetState extends State<ResponsableDataFormWidget> {
  late final TextEditingController nameController;
  late final TextEditingController cpfController;
  late final TextEditingController typeController;

  final FocusNode nameFocus = FocusNode();
  final FocusNode cpfFocus = FocusNode();
  final FocusNode typeFocus = FocusNode();

  final RegisterStore store = Modular.get();

  @override
  void initState() {
    // nameController = TextEditingController(text: store.state.responsible?.name);
    // cpfController = TextEditingController(text: store.state.responsible?.cpf);
    // typeController = TextEditingController(
    //   text: store.state.responsible?.type?.label,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.05),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            RegisterLabels.responsableDataFormMainText,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          const Divider(),
          TextFieldWidget(
            label: RegisterLabels.responsableDataFormNameLabel,
            placeholder: RegisterLabels.responsableDataFormNamePlaceholder,
            controller: nameController,
            textInputAction: TextInputAction.next,
            focusNode: nameFocus,
            onSubmitted: (String input) {
              Helpers.changeFocus(context, nameFocus, cpfFocus);
            },
            onChange: (String? input) {
              // store.state.responsible!.name = input ?? '';
              store.updateForm(store.state);
            },
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            label: RegisterLabels.responsableDataFormCPFLabel,
            placeholder: RegisterLabels.responsableDataFormCPFPlacehodler,
            mask: Masks.generateMask('###.###.###-##'),
            controller: cpfController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: cpfFocus,
            onSubmitted: (String input) {
              Helpers.changeFocus(context, nameFocus, typeFocus);
            },
            onChange: (String? input) {
              // store.state.responsible!.cpf = input ?? '';
              store.updateForm(store.state);
            },
          ),
          const SizedBox(height: 15),
          SelectFieldWidget<RelationshipType>(
            label: RegisterLabels.responsableDataFormRelationshipLabel,
            items: RelationshipType.values,
            itemsLabels: RelationshipType.values.map((type) => type.label).toList(),
            controller: typeController,
            focusNode: typeFocus,
            placeholder: RegisterLabels.responsableDataFormRelationshipPlaceholder,
            onSelectItem: (RelationshipType type) {
              typeController.text = type.label;
              // store.state.responsible!.type = type;
              store.updateForm(store.state);
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
