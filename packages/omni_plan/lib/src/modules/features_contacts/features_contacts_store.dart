import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/modules/features_contacts/features_contacts_repository.dart';

class FeaturesContactsStore extends NotifierStore<DioError, int>
    with Disposable {
  final FeaturesContactsRepository _repository = Modular.get();
  FeaturesContactsStore() : super(0);

  Future<void> getPlanFeaturesContacts() async {
    setLoading(true);
    await _repository.getPlanFeaturesContacts().then((details) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {}
}
