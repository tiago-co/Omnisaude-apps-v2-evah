import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/bank_model.dart';
import 'package:omni_plan/src/core/models/new_reimbursement_model.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/banks_list_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/new_reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementPersonalDataPage extends StatefulWidget {
  final PageController controller;
  const ReimbursementPersonalDataPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReimbursementPersonalDataPage> createState() =>
      _ReimbursementPersonalDataPageState();
}

class _ReimbursementPersonalDataPageState
    extends State<ReimbursementPersonalDataPage>
    with AutomaticKeepAliveClientMixin {
  final ReimbursementStepStore reimbursementStepStore = Modular.get();
  final NewReimbursementStore newReimbursementStore = Modular.get();
  final BanksListStore banksListStore = Modular.get();
  final UserStore userstore = Modular.get();
  final TextEditingController bankSearchController =
      TextEditingController(text: '');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController agencyController = TextEditingController();
  final TextEditingController bankController = TextEditingController(text: '');
  final TextEditingController digitController = TextEditingController(text: '');
  final TextEditingController accountController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode agencyFocusNode = FocusNode();
  FocusNode bankFocusNode = FocusNode();
  FocusNode accountFocusNode = FocusNode();
  FocusNode digFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    banksListStore.params.limit = '10';
    scrollController.addListener(() async {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          banksListStore.state.results!.length != banksListStore.state.count) {
        banksListStore.params.limit =
            (int.parse(banksListStore.params.limit!) + 10).toString();
        await banksListStore.getAvaliableBanks(banksListStore.params);
      }
    });
    banksListStore.getAvaliableBanks(banksListStore.params);

    newReimbursementStore.state.name =
        userstore.state.beneficiary!.individualPerson!.name;
    newReimbursementStore.updateForm(newReimbursementStore.state);
    banksListStore.getAvaliableBanks(banksListStore.params);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    agencyController.dispose();
    bankController.dispose();
    digitController.dispose();
    accountController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    agencyFocusNode.dispose();
    bankFocusNode.dispose();
    accountFocusNode.dispose();
    digFocusNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_pin_rounded,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ReimbursementLabels
                                .reimbursementPersonalDataBeneficiary,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            userstore
                                .state.beneficiary!.individualPerson!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).cardColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  ReimbursementLabels.reimbursementPersonalDataNotification,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  ReimbursementLabels.reimbursementPersonalDataDescription,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  ReimbursementLabels.reimbursementPersonalDataVerify,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          label: ReimbursementLabels
                              .reimbursementPersonalDataPhone,
                          focusNode: phoneFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          mask: Masks.generateMask('(##) # ####-####'),
                          onChange: (value) {
                            newReimbursementStore.state.phone = value!
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .replaceAll(' ', '')
                                .replaceAll('-', '');
                            newReimbursementStore
                                .updateForm(newReimbursementStore.state);
                          },
                        ),
                        TextFieldWidget(
                          label: ReimbursementLabels
                              .reimbursementPersonalDataEmail,
                          focusNode: emailFocusNode,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChange: (value) {
                            newReimbursementStore.state.email = value;
                            newReimbursementStore
                                .updateForm(newReimbursementStore.state);
                          },
                          validator: (value) {
                            if (!Helpers.isEmail(value!)) {
                              return ReimbursementLabels
                                  .reimbursementPersonalDataInavlidEmail;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  ReimbursementLabels.reimbursementPersonalDataPaymentData,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      TripleBuilder(
                        store: banksListStore,
                        builder: (_, triple) {
                          return TripleBuilder<BanksListStore, DioError,
                              BanksListResultsModel>(
                            store: banksListStore,
                            builder: (_, triple) {
                              return TextFieldWidget(
                                label: ReimbursementLabels
                                    .reimbursementPersonalDataBank,
                                controller: bankController,
                                readOnly: true,
                                suffixIcon: triple.isLoading
                                    ? const CircularProgressIndicator.adaptive()
                                    : SvgPicture.asset(
                                        Assets.arrowDown,
                                        color: Theme.of(context).cardColor,
                                        package: AssetsPackage.omniGeneral,
                                      ),
                                onTap: () async {
                                  await showModalBottomSheet(
                                    context: context,
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) =>
                                        _buildChooseDiseaseSheetWidget(_),
                                  );
                                },
                              );
                            },
                          );
                          // return SelectFieldWidget<BankModel>(
                          //   label: 'Banco *',
                          //   focusNode: bankFocusNode,
                          //   isEnabled: !triple.isLoading,
                          //   isLoading: triple.isLoading,
                          //   items: banksListStore.state.results!,
                          //   controller: bankController,
                          //   scrollController: scrollController,
                          //   onSelectItem: (BankModel bank) {
                          // newReimbursementStore.state.bank = bank.id;
                          // newReimbursementStore.state.bankName = bank.name;
                          // bankController.text = bank.name!;
                          // log(bank.name!);
                          // newReimbursementStore
                          //     .updateForm(newReimbursementStore.state);
                          //   },
                          //   itemsLabels: banksListStore.state.results!
                          //       .map((e) => e.name!)
                          //       .toList(),
                          //   placeholder: 'Clique para selecionar',
                          // );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              label: ReimbursementLabels
                                  .reimbursementPersonalDataAgency,
                              focusNode: agencyFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              mask: Masks().bankAgency,
                              controller: agencyController,
                              onChange: (value) {
                                newReimbursementStore.state.agency = value;
                                newReimbursementStore
                                    .updateForm(newReimbursementStore.state);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                            child: Text('/'),
                          ),
                          Expanded(
                            child: TextFieldWidget(
                              label: ReimbursementLabels
                                  .reimbursementPersonalDataAccount,
                              focusNode: accountFocusNode,
                              keyboardType: TextInputType.number,
                              mask: Masks().bankAcount,
                              controller: accountController,
                              onChange: (value) {
                                if (value!.isEmpty) {
                                  digitController.clear();
                                } else {
                                  newReimbursementStore.state.account = value;
                                }
                                newReimbursementStore
                                    .updateForm(newReimbursementStore.state);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                            child: Text('-'),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 50,
                              child: TripleBuilder<NewReimbursementStore,
                                  DioError, NewReimbursementModel>(
                                store: newReimbursementStore,
                                builder: (_, triplo) {
                                  return TextFieldWidget(
                                    isEnabled: triplo.state.account!.isNotEmpty,
                                    label: ReimbursementLabels
                                        .reimbursementPersonalDataaccountDigit,
                                    focusNode: digFocusNode,
                                    keyboardType: TextInputType.number,
                                    mask: Masks().bankAcountDig,
                                    controller: digitController,
                                    onChange: (value) {
                                      digitController.text = value!;

                                      if (value.isEmpty) {
                                        final accountNumber =
                                            accountController.text;
                                        newReimbursementStore.state.account =
                                            accountNumber;
                                      } else {
                                        final accountNumber =
                                            accountController.text +
                                                digitController.text;
                                        newReimbursementStore.state.account =
                                            accountNumber;
                                      }

                                      newReimbursementStore.updateForm(
                                        newReimbursementStore.state,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      ReimbursementLabels
                          .reimbursementPersonalDataAttentionAlert,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    ReimbursementLabels.reimbursementPersonalDataCantChange,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          TripleBuilder<NewReimbursementStore, DioError, NewReimbursementModel>(
        store: newReimbursementStore,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: validateFields(),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await widget.controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
                reimbursementStepStore
                    .updateStep(widget.controller.page!.round());
              }
            },
            text: ReimbursementLabels.reimbursementPersonalDataNext,
          );
        },
      ),
    );
  }

  Widget _buildChooseDiseaseSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BottomSheetHeaderWidget(
                  title:
                      ReimbursementLabels.reimbursementPersonalDataSearchBanks,
                  searchPlaceholder: ReimbursementLabels
                      .reimbursementPersonalDataBanksSearchPlaceholder,
                  showSearch: true,
                  controller: bankSearchController,
                  onSearch: (String? input) async {
                    banksListStore.params =
                        QueryParamsModel(name: input, limit: '10');
                    await banksListStore.getAvaliableBanks(
                      banksListStore.params,
                    );
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: TripleBuilder(
              store: banksListStore,
              builder: (_, triple) {
                if (triple.event == TripleEvent.error) {
                  return SafeArea(
                    child: RequestErrorWidget(
                      error: triple.error! as DioError,
                      onPressed: () {
                        banksListStore.params = QueryParamsModel(limit: '10');
                        banksListStore.getAvaliableBanks(banksListStore.params);
                      },
                    ),
                  );
                }

                if (triple.isLoading && banksListStore.state.results!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 25,
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const LoadingWidget(),
                          const SizedBox(height: 15),
                          Text(
                            ReimbursementLabels
                                .reimbursementPersonalDataBanksSearchLoading,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  );
                }

                if (banksListStore.state.results!.isEmpty) {
                  return const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 25,
                      ),
                      child: EmptyWidget(
                        message: ReimbursementLabels
                            .reimbursementPersonalDataEmptyBanks,
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!triple.isLoading) const SizedBox(height: 2.5),
                    if (triple.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          minHeight: 2.5,
                        ),
                      ),
                    Flexible(
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: banksListStore.state.results!.length,
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 15,
                          ),
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 50,
                          ),
                          itemBuilder: (_, index) {
                            return AbsorbPointer(
                              absorbing: triple.isLoading,
                              child: Opacity(
                                opacity: triple.isLoading ? 0.5 : 1.0,
                                child: _buildDiseaseItemWidget(
                                  banksListStore.state.results![index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseItemWidget(bank) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor.withOpacity(0.05),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Modular.to.pop();
          newReimbursementStore.state.bank = bank.id;
          newReimbursementStore.state.bankName = bank.name;
          bankController.text = bank.name!;
          newReimbursementStore.updateForm(newReimbursementStore.state);
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              bank.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              height: 10,
              width: 10,
              package: AssetsPackage.omniGeneral,
            ),
          ],
        ),
      ),
    );
  }

  bool validateFields() {
    if (newReimbursementStore.state.phone!.isEmpty ||
        newReimbursementStore.state.email!.isEmpty ||
        newReimbursementStore.state.phone!.isEmpty ||
        newReimbursementStore.state.bank!.isEmpty ||
        newReimbursementStore.state.agency!.isEmpty ||
        newReimbursementStore.state.account!.isEmpty ||
        digitController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
