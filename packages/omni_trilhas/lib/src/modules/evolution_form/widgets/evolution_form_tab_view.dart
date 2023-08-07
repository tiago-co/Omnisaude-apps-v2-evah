import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/evolution_forms_list_store.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/evolution_form_tab_view_item.dart';

class EvolutionFormTabView extends StatefulWidget {
  final EvolutionFormsListStore store;
  const EvolutionFormTabView({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<EvolutionFormTabView> createState() => _EvolutionFormTabViewState();
}

class _EvolutionFormTabViewState extends State<EvolutionFormTabView>
    with AutomaticKeepAliveClientMixin<EvolutionFormTabView> {
  @override
  void initState() {
    if (widget.store.state.isEmpty && !widget.store.isLoading) {
      widget.store.getSpecificEvolutionForm();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () => widget.store.getSpecificEvolutionForm(),
      child: TripleBuilder<EvolutionFormsListStore, DioError,
          List<EvolutionFormModel>>(
        store: widget.store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          } else if (!triple.isLoading && widget.store.state.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: EmptyWidget(
                  message: 'Nenhum Registro Encontrado',
                  textButton: 'Tentar Novamente',
                  isLoading: widget.store.isLoading,
                  onPressed: () => widget.store.getSpecificEvolutionForm(),
                ),
              ),
            );
          } else if (triple.event == TripleEvent.error) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        error: triple.error,
                        onPressed: () =>
                            widget.store.getSpecificEvolutionForm(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ListView.separated(
              separatorBuilder: (_, index) => const SizedBox(height: 20),
              itemCount: widget.store.state.length,
              itemBuilder: (_, index) => EvolutionFormTabViewItem(
                evolutionForm: widget.store.state[index],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
