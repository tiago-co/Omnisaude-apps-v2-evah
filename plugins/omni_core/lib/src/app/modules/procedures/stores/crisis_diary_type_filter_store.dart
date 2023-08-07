import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_historic_store.dart';
import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_store.dart';

class CrisisDiaryTypeFilterStore extends NotifierStore<Exception, int> {
  final CrisisDiaryStore crisisDiaryStore = Modular.get();
  final CrisisDiaryHistoricStore crisisDiaryHistoricStore = Modular.get();

  CrisisDiaryTypeFilterStore() : super(0);

  Future<void> onValueChanged(int? value) async {
    setLoading(true);
    update(value ?? 0);
    switch (state) {
      case 0:
        await crisisDiaryStore.getCrisisDiary().then((value) {
          setLoading(false);
        }).catchError((onError) {
          setLoading(false);
          setError(onError);
        });
        break;
      case 1:
        await crisisDiaryHistoricStore
            .getAnsweredCrisisDiaries(crisisDiaryHistoricStore.params)
            .then((value) {
          setLoading(false);
        }).catchError((onError) {
          setLoading(false);
          setError(onError);
        });
        break;
    }
  }
}
