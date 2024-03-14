import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/lecupon_errors_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/organizations_list_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/category_lecupon_filter_widget.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/coupon_rescue_type_filter_widget.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/organization_tile_widget.dart';
import 'package:omni_general/omni_general.dart';

import '../../core/resources/assets.dart';

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
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            // width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Descontos',
                    style: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2999999306 * ffem / fem,
                      color: Color(0xff1a1c22),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        // cupon1HH (5304:20216)
                        onPressed: () {
                          Modular.to.pushNamed(
                            '/newHome/discounts/cupons',
                            arguments: {
                              'categoryParam': '19',
                              'organizationId': 0,
                              'moduleName': 'Desconto em Farmácias',
                              'coverImage': '',
                              'couponRescueType': 'physical',
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 42 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xfffdf2f2),
                            borderRadius: BorderRadius.circular(12 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // margin: const EdgeInsets.all(12.0),
                                width: 54 * fem,
                                height: 64 * fem,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  // firstaidbagbhR (4511:32341)
                                  child: AspectRatio(
                                    aspectRatio: fem > 2 ? 2 : fem + 0.5,
                                    child: SvgPicture.asset(
                                      Assets.pillIcon,
                                      package: AssetsPackage.omniCore,
                                      color: const Color(
                                        0xffed8181,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                // pharmaciescH5 (5304:20225)
                                'Farmácias',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2999999306 * ffem / fem,
                                  color: Color(0xff1a1c22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12 * fem,
                      ),
                      TextButton(
                        // cuponrqd (5304:31508)
                        onPressed: () {
                          Modular.to.pushNamed(
                            '/newHome/discounts/cupons',
                            arguments: {
                              // 'moduleName': 'Desconto em Farmácia',
                              'categoryParam': '247',
                              'organizationId': 0,
                              'moduleName': 'Descontos em Exames',
                              'coverImage': '',
                              'couponRescueType': 'online',
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xffECF9F6),
                            borderRadius: BorderRadius.circular(12 * fem),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 5,
                                color: Colors.grey.shade200,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 42),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 54,
                                        height: 54,
                                        child: SvgPicture.asset(
                                          Assets.testTubeIcon,
                                          package: AssetsPackage.omniCore,
                                          color: Color(0xcc48BEC2),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'Exames',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2999999306 * ffem / fem,
                                          color: Color(0xff1a1c22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12 * fem,
                      ),
                      TextButton(
                        // cuponrqd (5304:31508)
                        onPressed: () {
                          Modular.to.pushNamed(
                            '/newHome/discounts/cupons',
                            arguments: {
                              // 'moduleName': 'Desconto em Farmácia',
                              'categoryParam': '',
                              'organizationId': 0,
                              'moduleName': 'Outros descontos',
                              'coverImage': '',
                              'couponRescueType': 'online',
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 42 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xfff6f6f8),
                            borderRadius: BorderRadius.circular(12 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // margin: const EdgeInsets.all(12.0),
                                width: 54 * fem,
                                height: 64 * fem,
                                child: AspectRatio(
                                  aspectRatio: fem > 2 ? 2 : fem + 0.5,
                                  child: SvgPicture.asset(
                                    Assets.medicalCrossIcon,
                                    package: AssetsPackage.omniCore,
                                    color: const Color(0xff949DB8),
                                  ),
                                ),
                              ),
                              Text(
                                // otherz4f (5304:31509)
                                'Outros',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2999999306 * ffem / fem,
                                  color: Color(0xff1a1c22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
