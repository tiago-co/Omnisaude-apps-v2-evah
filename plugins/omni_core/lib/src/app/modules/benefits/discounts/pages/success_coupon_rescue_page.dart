import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/rescue_coupon_store.dart';
import 'package:omni_general/omni_general.dart';

class SuccessCouponRescuePage extends StatefulWidget {
  final int organizationId;
  final RescueCouponModel coupon;
  const SuccessCouponRescuePage({
    Key? key,
    required this.coupon,
    required this.organizationId,
  }) : super(key: key);

  @override
  State<SuccessCouponRescuePage> createState() =>
      _SuccessCouponRescuePageState();
}

class _SuccessCouponRescuePageState extends State<SuccessCouponRescuePage> {
  final RescueCouponStore rescueCouponStore = Modular.get();

  @override
  void initState() {
    super.initState();
    rescueCouponStore.rescueCoupon(
      organizationId: widget.organizationId,
      rescueCoupon: widget.coupon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<RescueCouponStore, DioError, String>(
        store: rescueCouponStore,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }
          if (triple.event == TripleEvent.error) {
            return Center(
              child: RequestErrorWidget(
                message: 'Erro ao tentar ativar cupom',
                buttonText: 'Voltar',
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (_, constrains) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: constrains.maxWidth * 0.05,
                        ),
                        constraints: BoxConstraints(
                          minHeight: constrains.maxHeight,
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            children: [
                              const SuccessWidget(),
                              const SizedBox(height: 15),
                              Text(
                                'Cupom ativado com sucesso',
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              BottomButtonWidget(
                onPressed: () {
                  Modular.to.pop();
                },
                buttonType: BottomButtonType.outline,
                text: 'Voltar',
              ),
            ],
          );
        },
      ),
    );
  }
}
