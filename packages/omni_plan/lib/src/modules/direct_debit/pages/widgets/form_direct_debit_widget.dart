import 'package:dio/dio.dart';
import 'package:direct_debit_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/bank_model.dart';
import 'package:omni_plan/src/modules/direct_debit/store/direct_debit_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/banks_list_store.dart';

class FormDirectDebitWidget extends StatefulWidget {
  const FormDirectDebitWidget({Key? key}) : super(key: key);

  @override
  State<FormDirectDebitWidget> createState() => _FormDirectDebitWidgetState();
}

class _FormDirectDebitWidgetState extends State<FormDirectDebitWidget> {
  final DirectDebitStore store = Modular.get();
  final BanksListStore _bankListStore = Modular.get();
  final DateTimePickerService service = DateTimePickerService();
  final ScrollController scrollController = ScrollController();

  final TextEditingController bankController = TextEditingController(text: '');
  final TextEditingController agenciaController = TextEditingController();
  final TextEditingController digitoAgenciaController = TextEditingController();
  final TextEditingController contaController = TextEditingController();
  final TextEditingController digitoContaController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final FocusNode bankFocusNode = FocusNode();
  final FocusNode agenciaFocusNode = FocusNode();
  final FocusNode digitoAgenciaFocusNode = FocusNode();
  final FocusNode contaFocusNode = FocusNode();
  final FocusNode digitoContaFocusNode = FocusNode();
  final FocusNode textFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();

  @override
  void initState() {
    _bankListStore.params.limit = '50';
    scrollController.addListener(
      () {
        if (scrollController.offset ==
                scrollController.position.maxScrollExtent &&
            _bankListStore.state.results!.length !=
                _bankListStore.state.count) {
          _bankListStore.params.limit =
              (int.parse(_bankListStore.params.limit!) + 50).toString();
          _bankListStore.getAvaliableBanks(_bankListStore.params);
        }
      },
    );

    if (store.state.podeCadatastrarDebitoAutomatico ?? false) {
      _bankListStore.getAvaliableBanks(_bankListStore.params);
    }

    if (store.state.possuiDebitoAutomatico ?? false) {
      bankController.text = store.state.cdBanco ?? '-';
      agenciaController.text = store.state.cdAgenciaBancaria ?? '-';
      digitoAgenciaController.text = store.state.ieDigitoAgencia ?? '-';
      contaController.text = store.state.nrConta ?? '-';
      digitoContaController.text = store.state.nrDigitoConta ?? '-';
      bankController.text = store.state.cdBanco ?? '-';
      dateController.text = Formaters.dateToDDMMYYYY(store.state.dtInicio!);
    }

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    bankController.dispose();
    agenciaController.dispose();
    digitoAgenciaController.dispose();
    contaController.dispose();
    digitoContaController.dispose();
    textController.dispose();
    dateController.dispose();
    bankFocusNode.dispose();
    agenciaFocusNode.dispose();
    digitoAgenciaFocusNode.dispose();
    contaFocusNode.dispose();
    digitoContaFocusNode.dispose();
    textFocusNode.dispose();
    dateFocusNode.dispose();
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<BanksListStore, DioError, BanksListResultsModel>(
      store: _bankListStore,
      builder: (_, triple) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TripleBuilder<BanksListStore, DioError, BanksListResultsModel>(
                store: _bankListStore,
                builder: (_, triplo) {
                  return TextFieldWidget(
                    controller: bankController,
                    isEnabled: store.state.podeCadatastrarDebitoAutomatico!,
                    label: DirectDebitLabels.formDirectDebitBankLabel,
                    placeholder:
                        DirectDebitLabels.formDirectDebitBankPlaceholder,
                    readOnly: true,
                    suffixIcon: _bankListStore.isLoading
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
                        useSafeArea: false,
                        backgroundColor: Colors.transparent,
                        builder: (_) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: _modalBankList(),
                        ),
                      );
                    },
                  );
                },
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: TextFieldWidget(
                      controller: agenciaController,
                      isEnabled:
                          store.state.podeCadatastrarDebitoAutomatico ?? false,
                      mask: Masks.generateMask('#######'),
                      keyboardType: TextInputType.number,
                      label: DirectDebitLabels.formDirectDebitAgencyLabel,
                      placeholder:
                          DirectDebitLabels.formDirectDebitAgencyPlaceholder,
                      onSubmitted: (String input) {
                        Helpers.changeFocus(
                          context,
                          agenciaFocusNode,
                          digitoAgenciaFocusNode,
                        );
                      },
                      onChange: (String? input) {
                        store.params.cdAgenciaBancaria =
                            input!.replaceAll(RegExp(r'[^0-9]'), '');
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: TextFieldWidget(
                      controller: digitoAgenciaController,
                      isEnabled:
                          store.state.podeCadatastrarDebitoAutomatico ?? false,
                      mask: Masks.generateMask('#'),
                      keyboardType: TextInputType.number,
                      label: DirectDebitLabels.formDirectDebitAgencyDigitLabel,
                      placeholder: DirectDebitLabels
                          .formDirectDebitAgencyDigitPlaceholder,
                      onSubmitted: (String input) {
                        Helpers.changeFocus(
                          context,
                          digitoAgenciaFocusNode,
                          contaFocusNode,
                        );
                      },
                      onChange: (String? input) {
                        store.params.ieDigitoAgencia =
                            input!.replaceAll(RegExp(r'[^0-9]'), '');
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: TextFieldWidget(
                      controller: contaController,
                      isEnabled:
                          store.state.podeCadatastrarDebitoAutomatico ?? false,
                      mask: Masks.generateMask('##########'),
                      keyboardType: TextInputType.number,
                      label: DirectDebitLabels.formDirectDebitAccountLabel,
                      placeholder:
                          DirectDebitLabels.formDirectDebitAccountPlaceholder,
                      onSubmitted: (String input) {
                        Helpers.changeFocus(
                          context,
                          contaFocusNode,
                          digitoContaFocusNode,
                        );
                      },
                      onChange: (String? input) {
                        store.params.cdConta =
                            input!.replaceAll(RegExp(r'[^0-9]'), '');
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: TextFieldWidget(
                      controller: digitoContaController,
                      isEnabled:
                          store.state.podeCadatastrarDebitoAutomatico ?? false,
                      mask: Masks.generateMask('#'),
                      keyboardType: TextInputType.number,
                      label: DirectDebitLabels.formDirectDebitAccountDigitLabel,
                      placeholder: DirectDebitLabels
                          .formDirectDebitAccountDigitPlaceholder,
                      onSubmitted: (String input) {
                        Helpers.changeFocus(
                          context,
                          digitoContaFocusNode,
                          dateFocusNode,
                        );
                      },
                      onChange: (String? input) {
                        store.params.ieDigitoConta =
                            input!.replaceAll(RegExp(r'[^0-9]'), '');
                      },
                    ),
                  ),
                ],
              ),
              TextFieldWidget(
                controller: dateController,
                isEnabled: store.state.podeCadatastrarDebitoAutomatico!,
                label: DirectDebitLabels.formDirectDebitStartDateLabel,
                placeholder:
                    DirectDebitLabels.formDirectDebitStartDatePlaceholder,
                focusNode: dateFocusNode,
                onTap: () async {
                  await service
                      .selectDate(
                    context,
                    minDate: DateTime(2021),
                    enablePastDates: true,
                  )
                      .then(
                    (dateTime) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (dateTime == null) return;
                      dateController.text =
                          Formaters.dateToStringDate(dateTime);
                      store.params.dtInicio =
                          Formaters.dateToStringDateWithHifen(dateTime);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Container _modalBankList() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
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
                  title: DirectDebitLabels.formDirectDebitAvailableBanksLabel,
                  searchPlaceholder: DirectDebitLabels
                      .formDirectDebitAvailableBanksPlaceholder,
                  showSearch: true,
                  controller: textController,
                  onSearch: (String? input) {
                    _bankListStore.params.name = input;
                    _bankListStore.getAvaliableBanks(
                      _bankListStore.params,
                    );
                    _bankListStore.getAvaliableBanksParams(input);
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child:
                TripleBuilder<BanksListStore, DioError, BanksListResultsModel>(
              store: _bankListStore,
              builder: (_, triple) {
                if (triple.event == TripleEvent.error) {
                  return SafeArea(
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () {
                        _bankListStore.getAvaliableBanks(
                          _bankListStore.params,
                        );
                      },
                    ),
                  );
                }

                if ((_bankListStore.state.results!.isEmpty) &&
                    triple.isLoading) {
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
                            DirectDebitLabels.formDirectDebitSearchBanks,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  );
                }

                if (_bankListStore.state.results!.isEmpty) {
                  return const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 25,
                      ),
                      child: EmptyWidget(
                        message:
                            DirectDebitLabels.formDirectDebitBanksListEmpty,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 2.5,
                        ),
                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          minHeight: 1,
                        ),
                      ),
                    Flexible(
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _bankListStore.state.results!.length,
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
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.05),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    enableFeedback: true,
                                    onTap: () {
                                      bankController.text =
                                          Formaters.capitalizeIgnoringWords(
                                        _bankListStore
                                            .state.results![index].name!,
                                      );
                                      store.params.cdBanco = _bankListStore
                                          .state.results![index].code;
                                      _bankListStore
                                          .update(_bankListStore.state);
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Modular.to.pop();
                                    },
                                    title: Text(
                                      _bankListStore
                                          .state.results![index].name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minLeadingWidth: 0,
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
}
