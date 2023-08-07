import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/assistance_repository.dart';
import 'package:omni_assistance/src/assistance/stores/assistances_store.dart';
import 'package:omni_assistance/src/core/models/assistance_model.dart';

class AssistanceStore extends NotifierStore<DioError, AssistanceModel>
    with Disposable {
  AssistanceStore() : super(AssistanceModel());

  final AssistanceRepository _repository = Modular.get();
  final AssistancesStore assistancesStore = Modular.get();

  Future<void> createAssistance() async {
    setLoading(true);
    await _repository.createAssistance(state).then((assistance) {
      assistancesStore.params.limit = '10';
      assistancesStore.getAssistancesList(assistancesStore.params);
      update(assistance);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getAssistance(String id) async {
    setLoading(true);
    await _repository.getAssistance(id).then((assistance) {
      update(assistance);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
