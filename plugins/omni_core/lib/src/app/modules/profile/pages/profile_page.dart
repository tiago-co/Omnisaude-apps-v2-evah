import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/profile_enum.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_core/src/app/modules/profile/widgets/delete_account_modal_widget.dart';
import 'package:omni_core/src/app/modules/profile/widgets/profile_image_widget.dart';
import 'package:omni_core/src/app/modules/profile/widgets/profile_menu_item_widget.dart';
import 'package:omni_core/src/app/shared/widgets/subtitle_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:profile_labels/labels.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileStore store = Modular.get();
  @override
  void initState() {
    store.updateProfile(store.userStore.state.beneficiary!.individualPerson!);
    super.initState();
  }

  final TextEditingController cepController = TextEditingController();
  final TextEditingController ufController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController complementController = TextEditingController();

  final TextEditingController maritalStatusController = TextEditingController();

  final TextEditingController ethnicityController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController jsonValueController =
      TextEditingController(text: '');

  final TextEditingController genreController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  void updateAddressFields(ViaCepModel address) {
    cepController.text = address.zipCode!;
    ufController.text = address.uf!;
    cityController.text = address.city!;
    districtController.text = address.district ?? '';
    streetController.text = address.street ?? '';
    complementController.text = address.complement ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: ProfileLabels.profileTitle,
      ).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const ProfileImageWidget(),
            const SizedBox(height: 20),
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
                    store.getIndividualPerson().catchError((onError) {
                      Helpers.showDialog(
                        context,
                        RequestErrorWidget(
                          error: onError,
                          buttonText: ProfileLabels.close,
                          onPressed: () => Modular.to.pop(),
                        ),
                      );
                    });
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SafeArea(
                      child: TripleBuilder(
                        store: store,
                        builder: (_, triple) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (!triple.isLoading)
                                const SizedBox(height: 2.5),
                              if (triple.isLoading)
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                ),
                              const SizedBox(height: 17.5),
                              AbsorbPointer(
                                absorbing: triple.isLoading,
                                child: Opacity(
                                  opacity: triple.isLoading ? 0.5 : 1.0,
                                  child: _buildFormWidget,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildFormWidget {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleWidget(
            subtitle: ProfileLabels.profilePersonalDataSubTitle,
          ),
          const Divider(),
          ProfileMenuItemWidget(
            label: ProfileLabels.profileNameLabel,
            textEditingController: TextEditingController(),
            value: store.state.name,
            placeholder: ProfileLabels.profileNamePlaceholder,
            textLabelField: ProfileLabels.profileNameText,
            onChangeField: (String input) => {'nome': input},
          ),
          ProfileMenuItemWidget(
            label: ProfileLabels.profileMotherNameLabel,
            textEditingController: TextEditingController(),
            placeholder: ProfileLabels.profileMotherNamePlaceholder,
            value: store.state.motherName,
            textLabelField: ProfileLabels.profileMotherNameText,
            onChangeField: (String input) => {'nome_mae': input},
          ),
          ProfileMenuItemWidget(
            label: ProfileLabels.profileFatherNameLabel,
            textEditingController: TextEditingController(),
            placeholder: ProfileLabels.profileFatherNamePlaceholder,
            value: store.state.fatherName,
            textLabelField: ProfileLabels.profileFatherNameText,
            onChangeField: (String input) => {'nome_pai': input},
          ),
          ProfileMenuItemWidget(
            label: ProfileLabels.profileCPFLabel,
            textEditingController: TextEditingController(),
            readOnly: true,
            value: store.state.cpf != null
                ? Formaters.formatCPF(
                    store.state.cpf!,
                  )
                : '',
            placeholder: ProfileLabels.profileCPFPlaceholder,
            textLabelField: ProfileLabels.profileCPFText,
            onChangeField: (String input) => {'cpf': input},
          ),
          ProfileMenuItemWidget<MaritalStatus>(
            label: ProfileLabels.profileMaritalStatusLabel,
            textEditingController: maritalStatusController,
            jsonValueController: jsonValueController,
            items: MaritalStatus.values,
            itemsLabels: MaritalStatus.values.map((e) => e.label!).toList(),
            value: store.state.maritalStatus?.label,
            menuType: ProfileMenuItemType.select,
            textLabelField: ProfileLabels.profileMaritalStatusText,
            onSelectItem: (item) {
              maritalStatusController.text = item.label!;
              jsonValueController.text = item.toJson!;
            },
            onChangeField: (String input) => {'estado_civil': input},
          ),
          ProfileMenuItemWidget(
            menuType: ProfileMenuItemType.date,
            textEditingController: TextEditingController(),
            label: ProfileLabels.profileBirthLabel,
            value: store.state.birth != null
                ? Formaters.dateToStringDate(
                    Formaters.stringToDate(store.state.birth!),
                  )
                : '',
            placeholder: ProfileLabels.profileBirthPlaceholder,
            textLabelField: ProfileLabels.profileBirthText,
            onChangeField: (String input) => {
              'dt_nascimento': Formaters.dateToStringDate(
                Formaters.stringToDate(
                  input.replaceAll('/', '-'),
                  format: 'dd-MM-yyyy',
                ),
                format: 'yyyy-MM-dd',
              ),
            },
          ),
          ProfileMenuItemWidget<EthnicityType>(
            menuType: ProfileMenuItemType.select,
            textEditingController: ethnicityController,
            items: EthnicityType.values,
            itemsLabels:
                EthnicityType.values.map((type) => type.label).toList(),
            value: store.state.ethnicity?.label,
            label: ProfileLabels.profileEtnicityLabel,
            textLabelField: ProfileLabels.profileEtnicityText,
            jsonValueController: jsonValueController,
            onSelectItem: (item) {
              ethnicityController.text = item.label;
              jsonValueController.text = item.toJson!;
            },
            onChangeField: (String input) => {'cor': input},
          ),
          ProfileMenuItemWidget(
            label: ProfileLabels.profilePhoneLabel,
            textEditingController: birthController,
            value: store.state.phone,
            placeholder: ProfileLabels.profilePhonePlaceholder,
            textLabelField: ProfileLabels.profilePhoneText,
            mask: Masks().phone,
            onChangeField: (String input) => {
              'telefone': input
                  .replaceAll('(', '')
                  .replaceAll(')', '')
                  .replaceAll('-', '')
                  .replaceAll(' ', '')
            },
          ),
          ProfileMenuItemWidget(
            label: ProfileLabels.profileHeightLabel,
            textEditingController: TextEditingController(),
            value: store.state.height?.toStringAsFixed(2),
            placeholder: ProfileLabels.profileHeightPlaceholder,
            mask: Masks().height,
            textLabelField: ProfileLabels.profileHeightText,
            onChangeField: (String input) => {'altura': input},
          ),
          ProfileMenuItemWidget(
            label: ProfileLabels.profileWeightLabel,
            textEditingController: TextEditingController(),
            value: store.state.weight?.toString(),
            placeholder: ProfileLabels.profileWeightPlaceholder,
            textLabelField: ProfileLabels.profileWeightText,
            onChangeField: (String input) => {'peso': input},
          ),
          ProfileMenuItemWidget<GenreType>(
            menuType: ProfileMenuItemType.select,
            textEditingController: genreController,
            value: store.state.genre?.label,
            label: ProfileLabels.profileGenreLabel,
            textLabelField: ProfileLabels.profileGenreText,
            items: GenreType.values,
            itemsLabels: GenreType.values.map((type) => type.label).toList(),
            jsonValueController: jsonValueController,
            onSelectItem: (item) {
              genreController.text = item.label;
              jsonValueController.text = item.toJson!;
            },
            onChangeField: (String input) => {'sexo': input},
          ),
          ProfileMenuItemWidget<BloodType>(
            menuType: ProfileMenuItemType.select,
            textEditingController: bloodTypeController,
            value: store.state.bloodType?.label,
            textLabelField: ProfileLabels.profileBloodTypeText,
            label: ProfileLabels.profileBloodTypeLabel,
            items: BloodType.values,
            itemsLabels: BloodType.values.map((type) => type.label).toList(),
            jsonValueController: jsonValueController,
            onSelectItem: (item) {
              bloodTypeController.text = item.label;
              jsonValueController.text = item.toJson!;
            },
            onChangeField: (String input) => {'tipo_sanguineo': input},
          ),
          const SizedBox(height: 10),
          const SubtitleWidget(
            subtitle: ProfileLabels.profileAddressSubTitle,
          ),
          const SizedBox(height: 10),
          const Divider(),
          TripleBuilder<ProfileStore, DioError, IndividualPersonModel>(
            store: store,
            builder: (_, triple) {
              return Column(
                children: <Widget>[
                  ProfileMenuItemWidget(
                    onChangeField: (String input) => {'cep': input},
                    label: ProfileLabels.profileCEPLabel,
                    updateAddressFields: updateAddressFields,
                    textEditingController: cepController,
                    mask: Masks.generateMask('##.###-###'),
                    value: triple.state.address?.zipCode,
                    placeholder: ProfileLabels.profileCEPPlaceholder,
                    textLabelField: ProfileLabels.profileCEPText,
                    isCEP: true,
                  ),
                  ProfileMenuItemWidget(
                    label: ProfileLabels.profileUFLabel,
                    textEditingController: ufController,
                    value: triple.state.address?.state,
                    readOnly: true,
                    placeholder: ProfileLabels.profileUFPlaceholder,
                    textLabelField: ProfileLabels.profileUFText,
                    onChangeField: (String input) => {'': input},
                  ),
                  ProfileMenuItemWidget(
                    label: ProfileLabels.profileCityLabel,
                    textEditingController: cityController,
                    value: triple.state.address?.city,
                    readOnly: true,
                    placeholder: ProfileLabels.profileCityPlaceholder,
                    textLabelField: ProfileLabels.profileCityText,
                    onChangeField: (String input) => {'': input},
                  ),
                  ProfileMenuItemWidget(
                    label: ProfileLabels.profileDistrictLabel,
                    textEditingController: districtController,
                    value: triple.state.address?.district,
                    placeholder: ProfileLabels.profileDistrictPlaceholder,
                    textLabelField: ProfileLabels.profileDistrictText,
                    readOnly: triple.state.address?.district != '',
                    onChangeField: (String input) => {
                      'endereco': {'bairro': input},
                    },
                  ),
                  ProfileMenuItemWidget(
                    label: ProfileLabels.profileStreetLabel,
                    textEditingController: streetController,
                    placeholder: ProfileLabels.profileStreetPlaceholder,
                    value: triple.state.address?.street,
                    textLabelField: ProfileLabels.profileStreetText,
                    readOnly: triple.state.address?.street != '',
                    onChangeField: (String input) => {
                      'endereco': {'logradouro': input},
                    },
                  ),
                  ProfileMenuItemWidget(
                    label: ProfileLabels.profileComplementLabel,
                    textEditingController: complementController,
                    placeholder: ProfileLabels.profileComplementPlaceholder,
                    value: triple.state.address?.complement,
                    textLabelField: ProfileLabels.profileComplementText,
                    onChangeField: (String input) => {
                      'endereco': {'complemento': input},
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          const SubtitleWidget(
            subtitle: ProfileLabels.profileAccessDataSubTitle,
          ),
          const SizedBox(height: 10),
          const Divider(),
          ProfileMenuItemWidget(
            value: store.state.user!.username,
            textEditingController: TextEditingController(),
            textLabelField: ProfileLabels.profileUserText,
            readOnly: true,
          ),
          ProfileMenuItemWidget(
            value: store.state.user!.email,
            textEditingController: TextEditingController(),
            textLabelField: ProfileLabels.profileEmailText,
            readOnly: true,
          ),
          GestureDetector(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => const DeleteAccountModalWidget(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Center(
                child: Text(
                  ProfileLabels.profileExcludeAccount,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
