
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/modules/guide_providers/guide_providers_repository.dart';

class FiltersStore extends NotifierStore<DioError, List> with Disposable {
  final GuideRepositoryRepository _repository =
      Modular.get<GuideRepositoryRepository>();
  FiltersStore() : super([]);

  Future<void> getProviderSpecialties() async {
    setLoading(true);
    await _repository.getProvidersSpecialty().then((specialties) {
      update([]);
      update(specialties);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getProviderAddress() async {
    setLoading(true);
    await _repository.getProvidersAddress().then((address) {
      update([]);
      update(address);
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
