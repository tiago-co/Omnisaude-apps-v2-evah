import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/lecupon_errors_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/organizations_list_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/category_lecupon_filter_widget.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/coupon_rescue_type_filter_widget.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/organization_tile_widget.dart';
import 'package:omni_general/omni_general.dart';

class NewDiscountsPage extends StatefulWidget {
  final String? moduleName;
  final String? categoryParam;
  const NewDiscountsPage({
    Key? key,
    this.moduleName,
    this.categoryParam,
  }) : super(key: key);

  @override
  State<NewDiscountsPage> createState() => _NewDiscountsPageState();
}

class _NewDiscountsPageState extends State<NewDiscountsPage> {
  final OrganizationsListStore store = Modular.get();
  TextEditingController searchController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  @override
  void initState() {
    getPharmaOrganizationsListAndCategories();
    super.initState();
  }

  Future<void> getPharmaOrganizationsListAndCategories() async {
    await store.getPharmaOrganizationsList(categoryId: widget.categoryParam);
    await store.getDiscountCategories();
  }

  LecuponErrorsType identifyErrorType(DioError error) {
    if (error.toString().contains('Permissões')) {
      return LecuponErrorsType.permissionDenied;
    }
    return LecuponErrorsType.requestError;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.moduleName!,
      ).build(context) as AppBar,
      body: TripleBuilder<OrganizationsListStore, DioError, List<OrganizationModel>>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }
          if (triple.event == TripleEvent.error) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        message: triple.error!.response!.data['error'].toString(),
                        buttonText: identifyErrorType(triple.error!).buttonText,
                        onPressed: () async {
                          await store.getPharmaOrganizationsList(
                            categoryId: widget.categoryParam,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          if (!triple.isLoading && triple.state.isEmpty) {
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      physics: const BouncingScrollPhysics(),
                      child: EmptyWidget(
                        message: BenefitsLabels.discountsEmpty,
                        textButton: BenefitsLabels.tryAgain,
                        onPressed: () => store.getPharmaOrganizationsList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: widget.moduleName! == 'Outras Vantagens',
                  child: TextFieldWidget(
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    label: 'Buscar empresa',
                    onChange: (String? input) async {
                      if (input == null) return;
                      store.getOrganizationsListSearch(
                        input,
                      );
                    },
                    placeholder: 'Informe o nome da empresa',
                    suffixIcon: const Icon(Icons.search_rounded),
                  ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: widget.moduleName! == 'Outras Vantagens',
                      child: CategoryLecuponFilterWidget(
                        controller: searchController,
                      ),
                    ),
                    Visibility(
                      visible: widget.moduleName! == 'Outras Vantagens',
                      child: const SizedBox(width: 10),
                    ),
                    const CouponRescueTypeFilterWidget(),
                  ],
                ),
                const SizedBox(height: 10),
                if (!triple.isLoading && triple.state.isEmpty)
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message: 'Nenhuma organização encontrada!',
                          textButton: 'Tentar novamente',
                          onPressed: () {
                            searchController.clear();
                            store.getPharmaOrganizationsList(
                              categoryId: widget.categoryParam,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await store.getPharmaOrganizationsList(
                          categoryId: widget.categoryParam,
                        );
                      },
                      child: ListView.separated(
                        itemCount: store.state.length,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (_, index) => const SizedBox(height: 15),
                        itemBuilder: (_, index) {
                          return OrganizationTileWidget(
                            moduleName: widget.moduleName!,
                            organization: store.state[index],
                            rescueType: store.params.usageType,
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
