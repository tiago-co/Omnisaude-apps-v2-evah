import 'package:diseases/src/modules/diseases/stores/disease_category_type_store.dart';
import 'package:diseases_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class CategoryTextFieldWidget extends StatefulWidget {
  const CategoryTextFieldWidget({Key? key}) : super(key: key);

  @override
  State<CategoryTextFieldWidget> createState() =>
      _CategoryTextFieldWidgetState();
}

class _CategoryTextFieldWidgetState extends State<CategoryTextFieldWidget> {
  final TextEditingController typeItemController = TextEditingController();
  final TextEditingController chooseItemTypeSheetController =
      TextEditingController();
  final DiseaseCategoryTypeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      label: DiseasesLabels.createNewDiseaseCategoryLabel,
      controller: typeItemController,
      readOnly: true,
      suffixIcon: SvgPicture.asset(
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
          builder: (_) => _buildChooseItemTypeSheetWidget(_),
        );
      },
    );
  }

  Widget _buildChooseItemTypeSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom >= 60
                  ? MediaQuery.of(context).viewInsets.bottom - 60
                  : 0,
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BottomSheetHeaderWidget(
                  title: DiseasesLabels.createNewDiseaseCategoryLabel,
                  controller: chooseItemTypeSheetController,
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Scrollbar(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 15,
                      ),
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 50,
                      ),
                      itemBuilder: (_, index) {
                        return _buildTypeItemWidget(index);
                      },
                      itemCount: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeItemWidget(index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor.withOpacity(0.05),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          if (index == 0) {
            typeItemController.text = DiseasesLabels.pathologyLabel;

            store.updateForm(typeItemController.text);
          } else {
            typeItemController.text = DiseasesLabels.alergyLabel;

            store.updateForm(typeItemController.text);
          }
          FocusScope.of(context).requestFocus(FocusNode());
          Modular.to.pop();
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              index == 0
                  ? DiseasesLabels.pathologyLabel
                  : DiseasesLabels.alergyLabel,
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
}
