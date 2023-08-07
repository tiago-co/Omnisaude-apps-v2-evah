import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_historic_store.dart';

import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_store.dart';

class ExtraDataTypeStore extends NotifierStore<Exception, int> {
  final ExtraDataHistoricStore historicStore = Modular.get();
  final ExtraDataStore extraDataStore = Modular.get();

  ExtraDataTypeStore() : super(0);

  Future<void> onValueChanged(int? value) async {
    setLoading(true);
    update(value ?? 0);
    switch (state) {
      case 0:
        await extraDataStore.getExtraData(extraDataStore.params).then((value) {
          setLoading(false);
        }).catchError(
          (onError) {
            setLoading(false);
            setError(onError);
          },
        );
        break;
      case 1:
        await historicStore
            .getAnsweredExtraData(historicStore.params)
            .then((value) {
          setLoading(false);
        }).catchError(
          (onError) {
            setLoading(false);
            setError(onError);
          },
        );
        break;
    }
  }
}
