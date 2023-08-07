import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_general/omni_general.dart'
    show
        BottomButtonType,
        BottomButtonWidget,
        Helpers,
        Masks,
        SelectFieldWidget,
        TextFieldWidget,
        ViaCepModel,
        ZipCodeStore,
        states;
import 'package:omni_register_labels/labels.dart';

class AddressFormPage extends StatefulWidget {
  final PageController pageController;

  const AddressFormPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final RegisterStore store = Modular.get();

  late final TextEditingController zipCodeController;
  late final TextEditingController stateController;
  late final TextEditingController cityController;
  late final TextEditingController streetController;
  late final TextEditingController districtController;

  final FocusNode zipCodeFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode districtFocus = FocusNode();
  final FocusNode streetFocus = FocusNode();

  @override
  void initState() {
    zipCodeController = TextEditingController(
      text: store.state.individualPerson?.address?.zipCode,
    );
    stateController = TextEditingController(
      text: store.state.individualPerson?.address?.state,
    );
    cityController = TextEditingController(
      text: store.state.individualPerson?.address?.city,
    );
    districtController = TextEditingController(
      text: store.state.individualPerson?.address?.district,
    );
    streetController = TextEditingController(
      text: store.state.individualPerson?.address?.street,
    );

    super.initState();
  }

  void autocompleteAddress(String input) {
    store.zipCodeStore
        .getAddressByCep(input.replaceAll(RegExp(r'[^0-9]'), ''))
        .then((address) {
      store.state.individualPerson!.address!.zipCode = input;
      stateController.text = address.uf ?? stateController.text;
      cityController.text = address.city ?? cityController.text;
      districtController.text = address.district ?? districtController.text;
      streetController.text = address.street ?? streetController.text;

      store.state.individualPerson!.address!.state = stateController.text;
      store.state.individualPerson!.address!.city = cityController.text;
      store.state.individualPerson!.address!.district = districtController.text;
      store.state.individualPerson!.address!.street = streetController.text;

      store.updateForm(store.state);
    }).catchError((onError) {
      zipCodeController.clear();
      store.state.individualPerson!.address!.zipCode = zipCodeController.text;
      store.updateForm(store.state);
    });
  }

  @override
  void dispose() {
    zipCodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    districtController.dispose();
    streetController.dispose();

    zipCodeFocus.dispose();
    stateFocus.dispose();
    cityFocus.dispose();
    districtFocus.dispose();
    streetFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            RegisterLabels.addressFormMainText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            RegisterLabels.securityText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.all(15),
            child: TripleBuilder(
              store: store,
              builder: (_, triple) {
                return _buildFormWidget(triple.isLoading, _);
              },
            ),
          ),
        ),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: () {
                widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
              isDisabled: store.isDisabled(page: 3),
              isLoading: triple.isLoading,
              buttonType: BottomButtonType.outline,
              text: RegisterLabels.next,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFormWidget(bool isLoading, BuildContext _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: TripleBuilder<ZipCodeStore, Exception, ViaCepModel>(
                store: store.zipCodeStore,
                builder: (_, triple) {
                  return TextFieldWidget(
                    label: RegisterLabels.addressFormCEPLabel,
                    controller: zipCodeController,
                    focusNode: zipCodeFocus,
                    isEnabled: !isLoading || !triple.isLoading,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    suffixIcon: triple.isLoading
                        ? const CupertinoActivityIndicator()
                        : const Icon(Icons.location_on_rounded),
                    errorText: triple.error != null && !triple.isLoading
                        ? triple.error!.toString()
                        : null,
                    textCapitalization: TextCapitalization.none,
                    mask: Masks.generateMask('##.###-###'),
                    placeholder: RegisterLabels.addressFormCEPPlaceholder,
                    onSubmitted: autocompleteAddress,
                    onChange: (value) {
                      if (value!.length >= 10) {
                        autocompleteAddress(value);
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              flex: 3,
              child: SelectFieldWidget<MapEntry<String, String>>(
                label: RegisterLabels.addressFormUFLabel,
                items: states.entries.toList(),
                itemsLabels: states.entries.map((state) => state.key).toList(),
                placeholder: RegisterLabels.addressFormUFPlaceholder,
                isEnabled: !isLoading,
                controller: stateController,
                focusNode: stateFocus,
                onSelectItem: (MapEntry<String, String> state) {
                  stateController.text = state.value;
                  store.state.individualPerson!.address!.state = state.key;
                  store.updateForm(store.state);
                  Helpers.changeFocus(_, stateFocus, cityFocus);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        TextFieldWidget(
          label: RegisterLabels.addressFormCityLabel,
          controller: cityController,
          focusNode: cityFocus,
          placeholder: RegisterLabels.addressFormCityPlaceholder,
          isEnabled: !isLoading,
          textInputAction: TextInputAction.next,
          onChange: (String? input) {
            store.state.individualPerson!.address!.city = input;
            store.updateForm(store.state);
          },
          onSubmitted: (String input) {
            Helpers.changeFocus(_, cityFocus, districtFocus);
          },
        ),
        const SizedBox(height: 15),
        TextFieldWidget(
          label: RegisterLabels.addressFormDistrictLabel,
          placeholder: RegisterLabels.addressFormDistrictPlaceholder,
          controller: districtController,
          focusNode: districtFocus,
          isEnabled: !isLoading,
          textInputAction: TextInputAction.next,
          onChange: (String? input) {
            store.state.individualPerson!.address!.district = input;
            store.updateForm(store.state);
          },
          onSubmitted: (String input) {
            Helpers.changeFocus(_, districtFocus, streetFocus);
          },
        ),
        const SizedBox(height: 15),
        TextFieldWidget(
          label: RegisterLabels.addressFormStreetLabel,
          placeholder: RegisterLabels.addressFormStreetPlaceholder,
          controller: streetController,
          focusNode: streetFocus,
          isEnabled: !isLoading,
          textInputAction: TextInputAction.next,
          onChange: (String? input) {
            store.state.individualPerson!.address!.street = input;
            store.updateForm(store.state);
          },
          onSubmitted: (String input) {
            Helpers.changeFocus(_, streetFocus, FocusNode());
          },
        ),
        const SizedBox(height: 15),
        // TextFieldWidget(
        //   label: RegisterLabels.addressFormComplementLabel,
        //   placeholder: RegisterLabels.addressFormComplementPlaceholder,
        //   controller: complementController,
        //   focusNode: complementFocus,
        //   isEnabled: !isLoading,
        //   onChange: (String? input) {
        //     store.state.individualPerson!.address!.complement = input;
        //     store.updateForm(store.state);
        //   },
        //   onSubmitted: (String input) {
        //     Helpers.changeFocus(_, complementFocus, FocusNode());
        //   },
        // ),
        // const SizedBox(height: 15),
      ],
    );
  }
}
