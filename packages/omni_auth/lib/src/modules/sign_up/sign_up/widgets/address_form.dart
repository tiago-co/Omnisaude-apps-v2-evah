import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';

import 'package:omni_general/omni_general.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final ZipCodeStore zipCodeStore = Modular.get();
  final RegisterStore _profileStore = Modular.get();

  late final TextEditingController zipCodeController = TextEditingController();
  late final TextEditingController stateController = TextEditingController();
  late final TextEditingController cityController = TextEditingController();
  late final TextEditingController streetController = TextEditingController();
  late final TextEditingController districtController = TextEditingController();

  final FocusNode zipCodeFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode districtFocus = FocusNode();
  final FocusNode streetFocus = FocusNode();

  void autocompleteAddress(String input) {
    zipCodeStore.getAddressByCep(input.replaceAll(RegExp(r'[^0-9]'), '')).then((address) {
      _profileStore.state.individualPerson?.address!.zipCode = input.replaceAll(RegExp(r'[^0-9]'), '');
      stateController.text = address.uf ?? stateController.text;
      cityController.text = address.city ?? cityController.text;
      districtController.text = address.district ?? districtController.text;
      streetController.text = address.street ?? streetController.text;

      _profileStore.state.individualPerson?.address!.state = stateController.text;
      _profileStore.state.individualPerson?.address!.city = cityController.text;
      _profileStore.state.individualPerson?.address!.district = districtController.text;
      _profileStore.state.individualPerson?.address!.street = streetController.text;

      _profileStore.updateForm(_profileStore.state);
    }).catchError((onError) {
      zipCodeController.clear();
      _profileStore.state.individualPerson?.address!.zipCode = zipCodeController.text;
      _profileStore.updateForm(_profileStore.state);
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return TripleBuilder<ZipCodeStore, Exception, ViaCepModel>(
      store: zipCodeStore,
      builder: (context, triple) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: TextFieldWidget(
                    label: 'CEP*',
                    controller: zipCodeController,
                    focusNode: zipCodeFocus,
                    isEnabled: !triple.isLoading,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    suffixIcon: triple.isLoading
                        ? const SizedBox(
                            height: 12,
                            width: 12,
                            child: FittedBox(
                              child: LoadingWidget(
                                isStretch: false,
                              ),
                            ),
                          )
                        : const Icon(Icons.location_on_rounded),
                    // errorText: triple.error != null && !triple.isLoading ? triple.error!.toString() : null,
                    textCapitalization: TextCapitalization.none,
                    mask: Masks.generateMask('##.###-###'),
                    placeholder: 'Código postal',
                    onSubmitted: autocompleteAddress,
                    focusedborder: InputBorder.none,
                    padding: EdgeInsets.zero,
                    fem: fem,
                    onChange: (value) {
                      if (value!.length >= 10) {
                        autocompleteAddress(value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 3,
                  child: SelectFieldWidget<MapEntry<String, String>>(
                    label: 'UF*',
                    items: states.entries.toList(),
                    itemsLabels: states.entries.map((state) => state.key).toList(),
                    placeholder: 'UF',
                    isEnabled: !triple.isLoading,
                    controller: stateController,
                    padding: EdgeInsets.zero,
                    focusNode: stateFocus,
                    fem: fem,
                    onSelectItem: (MapEntry<String, String> state) {
                      stateController.text = state.value;
                      _profileStore.state.individualPerson?.address!.state = state.value;
                      _profileStore.updateForm(_profileStore.state);
                      Helpers.changeFocus(context, stateFocus, cityFocus);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              label: 'Cidade*',
              controller: cityController,
              focusNode: cityFocus,
              padding: EdgeInsets.zero,
              placeholder: 'Cidade',
              isEnabled: !triple.isLoading,
              textInputAction: TextInputAction.next,
              focusedborder: InputBorder.none,
              fem: fem,
              onChange: (String? input) {
                _profileStore.state.individualPerson?.address!.city = input;
                _profileStore.updateForm(_profileStore.state);
              },
              onSubmitted: (String input) {
                Helpers.changeFocus(context, cityFocus, districtFocus);
              },
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              label: 'Bairro*',
              placeholder: 'Bairro',
              controller: districtController,
              padding: EdgeInsets.zero,
              focusNode: districtFocus,
              isEnabled: !triple.isLoading,
              textInputAction: TextInputAction.next,
              focusedborder: InputBorder.none,
              fem: fem,
              onChange: (String? input) {
                _profileStore.state.individualPerson?.address!.district = input;
                _profileStore.updateForm(_profileStore.state);
              },
              onSubmitted: (String input) {
                Helpers.changeFocus(context, districtFocus, streetFocus);
              },
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              label: 'Rua*',
              placeholder: 'Rua',
              controller: streetController,
              padding: EdgeInsets.zero,
              focusNode: streetFocus,
              isEnabled: !triple.isLoading,
              textInputAction: TextInputAction.next,
              focusedborder: InputBorder.none,
              fem: fem,
              onChange: (String? input) {
                _profileStore.state.individualPerson?.address!.street = input;
                _profileStore.updateForm(_profileStore.state);
              },
              onSubmitted: (String input) {
                Helpers.changeFocus(context, streetFocus, FocusNode());
              },
            ),
            const SizedBox(height: 15),
            // TextFieldWidget(
            //   label: RegisterLabels.addressFormComplementLabel,
            //   placeholder: RegisterLabels.addressFormComplementPlaceholder,
            //   controller: complementController,
            //   focusNode: complementFocus,
            //   isEnabled: !triple.isLoading,
            //   onChange: (String? input) {
            //     store.state.address!.complement = input;
            //     store.updateProfile(store.state);
            //   },
            //   onSubmitted: (String input) {
            //     Helpers.changeFocus(context, complementFocus, FocusNode());
            //   },
            // ),
            // const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}
