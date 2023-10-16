import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/cupons_list_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/cupon_card_widget.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/cupon_widget.dart';
import 'package:omni_general/omni_general.dart';

class NewCuponsPage extends StatefulWidget {
  final int organizationId;
  final String? couponRescueType;
  final String moduleName;
  final String coverImage;
  const NewCuponsPage({
    Key? key,
    required this.organizationId,
    required this.moduleName,
    required this.coverImage,
    this.couponRescueType,
  }) : super(key: key);

  @override
  State<NewCuponsPage> createState() => _NewCuponsPageState();
}

class _NewCuponsPageState extends State<NewCuponsPage> {
  final CuponsListStore store = CuponsListStore();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // store.params.usageType = widget.couponRescueType;
    // store.getOrganizationCupons(organzationId: widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.storage_outlined),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child:
              // TripleBuilder<CuponsListStore, DioError, List<CupomModel>>(
              //   store: store,
              //   builder: (_, triple) {
              // if (triple.isLoading) {
              //   return const LoadingWidget();
              // }
              // return
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Titulo do módulo',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Buscar...',
                controller: TextEditingController(),
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                textCapitalization: TextCapitalization.none,
                prefixIcon: const Icon(Icons.search),
                onChange: (String? input) {
                  // store.state.username = input;
                  // store.updateForm(store.state);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const CuponWidget();
                },
              )
            ],
          )
          // ;
          // if (triple.event == TripleEvent.error) {
          //   return Column(
          //     children: [
          //       Expanded(
          //         child: Center(
          //           child: SingleChildScrollView(
          //             clipBehavior: Clip.antiAlias,
          //             physics: const BouncingScrollPhysics(),
          //             child: RequestErrorWidget(
          //               error: triple.error,
          //               onPressed: () => store.getOrganizationCupons(
          //                 organzationId: widget.organizationId,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   );
          // }
          // if (!triple.isLoading && triple.state.isEmpty) {
          //   return Center(
          //     child: SingleChildScrollView(
          //       clipBehavior: Clip.antiAlias,
          //       padding: const EdgeInsets.symmetric(horizontal: 15),
          //       physics: const BouncingScrollPhysics(),
          //       child: EmptyWidget(
          //         message: BenefitsLabels.cuponsEmpty,
          //         textButton: BenefitsLabels.tryAgain,
          //         onPressed: () => store.getOrganizationCupons(
          //           organzationId: widget.organizationId,
          //         ),
          //       ),
          //     ),
          //   );
          // }
          // return RefreshIndicator(
          //   onRefresh: () async {
          //     await store.getOrganizationCupons(
          //       organzationId: widget.organizationId,
          //     );
          //   },
          //   child: ListView.separated(
          //     physics: const AlwaysScrollableScrollPhysics(),
          //     separatorBuilder: (context, index) => const SizedBox(height: 20),
          //     shrinkWrap: true,
          //     itemCount: store.state.length > 3 ? 3 : store.state.length,
          //     itemBuilder: (_, index) {
          //       store.state[index].organizationId = widget.organizationId;

          //       return CuponCardWidget(
          //         model: store.state[index],
          //         coverImage: widget.coverImage,
          //       );
          //     },
          //   ),
          // );
          //   },
          // ),
          ),
    );
  }
}
