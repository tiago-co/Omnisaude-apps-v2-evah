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
      appBar: const NavBarWidget(title: 'Perfil').build(context) as AppBar,
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
                          buttonText: 'Fechar',
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
          const SubtitleWidget(subtitle: 'Dados Pessoais *'),
          const Divider(),
          ProfileMenuItemWidget(
            reverse: false,
            label: 'Nome completo',
            textEditingController: TextEditingController(),
            value: store.state.name,
            placeholder: 'Digite seu nome completo',
            textLabelField: 'Nome',
            onChangeField: (String input) => {'nome': input},
          ),
          ProfileMenuItemWidget(
            label: 'Nome da mãe',
            textEditingController: TextEditingController(),
            placeholder: 'Digite o nome da sua mãe',
            value: store.state.motherName,
            textLabelField: 'Nome da Mãe',
            onChangeField: (String input) => {'nome_mae': input},
          ),
          ProfileMenuItemWidget(
            label: 'Nome do pai',
            textEditingController: TextEditingController(),
            placeholder: 'Digite o nome do seu pai',
            value: store.state.fatherName,
            textLabelField: 'Nome do Pai',
            onChangeField: (String input) => {'nome_pai': input},
          ),
          ProfileMenuItemWidget(
            label: 'CPF',
            textEditingController: TextEditingController(),
            readOnly: true,
            value: store.state.cpf != null
                ? Formaters.formatCPF(
                    store.state.cpf!,
                  )
                : '',
            placeholder: 'Digite seu CPF',
            textLabelField: 'CPF',
            onChangeField: (String input) => {'cpf': input},
          ),
          ProfileMenuItemWidget<MaritalStatus>(
            label: 'Estado Civil',
            textEditingController: maritalStatusController,
            jsonValueController: jsonValueController,
            items: MaritalStatus.values,
            itemsLabels: MaritalStatus.values.map((e) => e.label!).toList(),
            value: store.state.maritalStatus?.label,
            menuType: ProfileMenuItemType.select,
            textLabelField: 'Estado Civil',
            onSelectItem: (item) {
              maritalStatusController.text = item.label!;
              jsonValueController.text = item.toJson!;
            },
            onChangeField: (String input) => {'estado_civil': input},
          ),
          ProfileMenuItemWidget(
            menuType: ProfileMenuItemType.date,
            textEditingController: TextEditingController(),
            label: 'Data de nascimento',
            value: store.state.birth != null
                ? Formaters.dateToStringDate(
                    Formaters.stringToDate(store.state.birth!),
                  )
                : '',
            placeholder: 'Informe sua data de nascimento',
            textLabelField: 'Nascimento',
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
            label: 'Etnia',
            textLabelField: 'Etnia',
            jsonValueController: jsonValueController,
            onSelectItem: (item) {
              ethnicityController.text = item.label;
              jsonValueController.text = item.toJson!;
            },
            onChangeField: (String input) => {'cor': input},
          ),
          ProfileMenuItemWidget(
            label: 'Telefone',
            textEditingController: birthController,
            value: store.state.phone,
            placeholder: 'Informe seu Telefone',
            textLabelField: 'Telefone',
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
            label: 'Altura',
            textEditingController: TextEditingController(),
            value: store.state.height?.toStringAsFixed(2),
            placeholder: 'Informe sua altura',
            mask: Masks().height,
            textLabelField: 'Altura',
            onChangeField: (String input) => {'altura': input},
          ),
          ProfileMenuItemWidget(
            label: 'Peso',
            textEditingController: TextEditingController(),
            value: store.state.weight?.toString(),
            placeholder: 'Informe seu peso',
            textLabelField: 'Peso',
            onChangeField: (String input) => {'peso': input},
          ),
          ProfileMenuItemWidget<GenreType>(
            menuType: ProfileMenuItemType.select,
            textEditingController: genreController,
            value: store.state.genre?.label,
            label: 'Gênero',
            textLabelField: 'Gênero',
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
            textLabelField: 'Tipo Sanguíneo',
            label: 'Tipo Sanguíneo',
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
          const SubtitleWidget(subtitle: 'Endereço *'),
          const SizedBox(height: 10),
          const Divider(),
          TripleBuilder<ProfileStore, DioError, IndividualPersonModel>(
            store: store,
            builder: (_, triple) {
              return Column(
                children: <Widget>[
                  ProfileMenuItemWidget(
                    onChangeField: (String input) => {'cep': input},
                    label: 'CEP',
                    updateAddressFields: updateAddressFields,
                    textEditingController: cepController,
                    mask: Masks.generateMask('##.###-###'),
                    value: triple.state.address?.zipCode,
                    placeholder: 'Informe seu CEP',
                    textLabelField: 'CEP',
                    isCEP: true,
                  ),
                  ProfileMenuItemWidget(
                    label: 'UF',
                    textEditingController: ufController,
                    value: triple.state.address?.state,
                    readOnly: true,
                    placeholder: 'Informe sua UF',
                    textLabelField: 'UF',
                    onChangeField: (String input) => {'': input},
                  ),
                  ProfileMenuItemWidget(
                    label: 'Cidade',
                    textEditingController: cityController,
                    value: triple.state.address?.city,
                    readOnly: true,
                    placeholder: 'Informe sua cidade',
                    textLabelField: 'Cidade',
                    onChangeField: (String input) => {'': input},
                  ),
                  ProfileMenuItemWidget(
                    label: 'Bairro',
                    textEditingController: districtController,
                    value: triple.state.address?.district,
                    placeholder: 'Informe seu Bairro',
                    textLabelField: 'Bairro',
                    readOnly: triple.state.address?.district != '',
                    onChangeField: (String input) => {
                      'endereco': {'bairro': input},
                    },
                  ),
                  ProfileMenuItemWidget(
                    label: 'Endereço',
                    textEditingController: streetController,
                    placeholder: 'Informe seu endereço',
                    value: triple.state.address?.street,
                    textLabelField: 'Endereço',
                    readOnly: triple.state.address?.street != '',
                    onChangeField: (String input) => {
                      'endereco': {'logradouro': input},
                    },
                  ),
                  ProfileMenuItemWidget(
                    label: 'Complemento',
                    textEditingController: complementController,
                    placeholder: 'Complemento',
                    value: triple.state.address?.complement,
                    textLabelField: 'Complemento',
                    onChangeField: (String input) => {
                      'endereco': {'complemento': input},
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          const SubtitleWidget(subtitle: 'Dados de Acesso *'),
          const SizedBox(height: 10),
          const Divider(),
          ProfileMenuItemWidget(
            value: store.state.user!.username,
            textEditingController: TextEditingController(),
            textLabelField: 'Usuário',
            readOnly: true,
          ),
          ProfileMenuItemWidget(
            value: store.state.user!.email,
            textEditingController: TextEditingController(),
            textLabelField: 'E-mail',
            readOnly: true,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                'Excluir conta',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              trailing: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => const DeleteAccountModalWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
