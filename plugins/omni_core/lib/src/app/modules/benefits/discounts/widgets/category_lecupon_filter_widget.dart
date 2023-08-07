import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/organizations_list_store.dart';
import 'package:omni_general/omni_general.dart';

class CategoryLecuponFilterWidget extends StatefulWidget {
  TextEditingController? controller;

  CategoryLecuponFilterWidget({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  State<CategoryLecuponFilterWidget> createState() =>
      _RefundRequestStatusFilterWidgetState();
}

class _RefundRequestStatusFilterWidgetState
    extends State<CategoryLecuponFilterWidget> {
  final OrganizationsListStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          enableDrag: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: (_) => _buildStatusSheetWidget(_),
        );
      },
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: TripleBuilder<OrganizationsListStore, DioError,
          List<OrganizationModel>>(
        store: store,
        builder: (_, triple) {
          return Container(
            decoration: BoxDecoration(
              color: store.params.categoryId != ''
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  Assets.filter,
                  package: AssetsPackage.omniGeneral,
                  width: 15,
                  height: 15,
                  color: store.params.categoryId != ''
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  store.params.categoryId != ''
                      ? store.listDiscountCategories
                          .firstWhere(
                            (element) =>
                                element.id.toString() ==
                                store.params.categoryId,
                          )
                          .title!
                      : 'Categoria',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: store.params.categoryId != ''
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                ),
                if (store.params.categoryId == '') const SizedBox(width: 10),
                if (store.params.categoryId != '')
                  GestureDetector(
                    onTap: () {
                      store.getPharmaOrganizationsList(
                        categoryId: '',
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Limpar',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
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

  Widget _buildStatusSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHeaderWidget(title: 'Categoria'),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: store.listDiscountCategories.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) {
                    return _buildRadioItemWidget(
                      store.listDiscountCategories[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioItemWidget(DiscountCategoryModel category) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RadioListTile<DiscountCategoryModel>(
        value: category,
        groupValue: store.params.categoryId != ''
            ? store.listDiscountCategories.firstWhere(
                (element) => element.id.toString() == store.params.categoryId,
              )
            : null,
        onChanged: (DiscountCategoryModel? categoryModel) async {
          store.getPharmaOrganizationsList(
            categoryId: category.id.toString(),
          );
          if (widget.controller != null) {
            widget.controller!.clear();
          }
          Modular.to.pop();
        },
        dense: true,
        activeColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.zero,
        title: Text(
          category.title!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
