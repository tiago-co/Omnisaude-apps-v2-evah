import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

class NewSchedulingCategoryStore
    extends NotifierStore<DioError, List<ProfessionalCategoryModel>>
    with Disposable {
  final SchedulingRepository _repository = Modular.get();
  NewSchedulingCategoryStore() : super([]);

  Future<void> getSchedulingCategory() async {
    setLoading(true);
    await _repository.getSchedulingCategory().then((categories) {
      update(categories!);
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
