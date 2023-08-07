import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/src/core/models/recommended_bots_model.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/bot_recommendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/widgets/recomendation_card_widget.dart';
import 'package:omni_mediktor_labels/labels.dart';

class MediktorBotRecomendationsPage extends StatefulWidget {
  final String specialtyId;
  const MediktorBotRecomendationsPage({
    Key? key,
    required this.specialtyId,
  }) : super(key: key);

  @override
  _MediktorBotRecomendationsPageState createState() =>
      _MediktorBotRecomendationsPageState();
}

class _MediktorBotRecomendationsPageState
    extends State<MediktorBotRecomendationsPage> {
  final BotRecommendationStore store = Modular.get();
  final UserStore userStore = Modular.get<UserStore>();
  @override
  void initState() {
    store.getRecomendedBots(widget.specialtyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: MediktorLabels.mediktorBotRecomendationsTitle,
      ).build(context) as AppBar,
      body:
          TripleBuilder<BotRecommendationStore, DioError, RecommendedBotsModel>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }
          if (triple.event == TripleEvent.error) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        error: store.error,
                        onPressed: () async {
                          await store.getRecomendedBots(widget.specialtyId);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(15),
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return RecomendationCardWidget(
                    image: store.state.recomendedBots![index].logo,
                    asset: '',
                    title: store.state.recomendedBots![index].nome!,
                    description: store.state.recomendedBots![index].descricao!,
                    onTap: () {
                      Modular.to.pushNamed(
                        '/home/bots/',
                        arguments: {
                          'title': store.state.recomendedBots![index].nome,
                          'botId':
                              store.state.recomendedBots![index].idOriginal,
                          'jwt': userStore.state.jwt,
                          'beneficiary': userStore.state.beneficiary,
                        },
                      );
                    },
                  );
                },
                itemCount: store.state.recomendedBots!.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
