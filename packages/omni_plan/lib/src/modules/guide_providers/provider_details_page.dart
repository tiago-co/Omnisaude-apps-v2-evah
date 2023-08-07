import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:guide_providers_labels/labels.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_provider_model.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/guide_providers_store.dart';

class ProviderDetailsPage extends StatefulWidget {
  final PlanProviderModel provider;
  const ProviderDetailsPage({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  State<ProviderDetailsPage> createState() => _ProviderDetailsPageState();
}

class _ProviderDetailsPageState extends State<ProviderDetailsPage> {
  final GuideProvidersStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.provider.nmPrestador ??
            GuideProvidersLabels.prodiverDetailsTitle,
        actions: [
          TripleBuilder(
            store: store,
            builder: (context, triple) {
              if (triple.isLoading) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  height: 55,
                  width: 55,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
              return IconButton(
                onPressed: () async {
                  await store.setFavoriteProvider(widget.provider).then(
                    (value) {
                      showInSnackBar(
                        widget.provider.isFavorite!
                            ? GuideProvidersLabels.prodiverDetailsSuccessAdd
                            : GuideProvidersLabels.prodiverDetailsSuccessRemove,
                        Colors.green,
                      );
                    },
                  ).catchError(
                    (onError) {
                      showInSnackBar(
                        GuideProvidersLabels.prodiverDetailsSaveError,
                        Colors.red,
                      );
                    },
                  );
                },
                icon: widget.provider.isFavorite!
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
              );
            },
          )
        ],
      ).build(context) as AppBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsName,
                value: widget.provider.nmPrestador,
              ),
              if (widget.provider.dsTipoPrestador != '') const Divider(),
              if (widget.provider.dsTipoPrestador != '')
                DetailsItemWidget(
                  label: GuideProvidersLabels.prodiverDetailsType,
                  value: '${widget.provider.dsTipoPrestador?.substring(0, 1)}'
                      '${widget.provider.dsTipoPrestador?.substring(1, widget.provider.dsTipoPrestador?.length).toLowerCase()}',
                ),
              const Divider(),
              if (widget.provider.dsTipoPrestador != '')
                DetailsItemWidget(
                  label: GuideProvidersLabels.prodiverDetailsType,
                  value: '${widget.provider.dsTipoPrestador?.substring(0, 1)}'
                      '${widget.provider.dsTipoPrestador?.substring(1, widget.provider.dsTipoPrestador?.length).toLowerCase()}',
                ),
              if (widget.provider.dsTipoPrestador != '') const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsSpecialty,
                value: widget.provider.dsEspecialidades,
              ),
              const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsCode,
                value: widget.provider.cdPrestador,
              ),
              const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsState,
                value: widget.provider.dsEstado,
              ),
              const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsCounty,
                value: widget.provider.dsMunicipio,
              ),
              const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsNeighborhood,
                value: widget.provider.dsBairro,
              ),
              const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsAddress,
                value: widget.provider.dsLogradouro,
              ),
              const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsComplement,
                value: widget.provider.dsComplemento,
              ),
              const Divider(),
              DetailsItemWidget(
                label: GuideProvidersLabels.prodiverDetailsUpdate,
                value: widget.provider.dtAtualizacao != null
                    ? Formaters.dateToStringDateTime(
                        Formaters.stringToDateTime(
                          widget.provider.dtAtualizacao!,
                        ),
                      )
                    : '',
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
