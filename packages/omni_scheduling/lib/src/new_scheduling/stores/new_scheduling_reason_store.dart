import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart'
    show KeyValueModel, BeneficiaryRepository;
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

// ignore: must_be_immutable
class NewSchedulingReasonStore
    extends NotifierStore<DioError, List<KeyValueModel>> with Disposable {
  final BeneficiaryRepository _beneficiaryRepository = Modular.get();
  final SchedulingRepository _repository = Modular.get();
  bool selectActive = false;

  NewSchedulingReasonStore() : super([]);

  Future<void> getSchedulingReasons() async {
    setLoading(true);
    await _beneficiaryRepository.getOperatorConfigs().then((oprConfigs) async {
      if (!oprConfigs.useCustomSchedulingReason) {
        selectActive = false;
        setLoading(false);
        return;
      }
      selectActive = true;
      await _repository.getSchedulingReasons().then((reasons) {
        if (reasons!.isEmpty) {
          selectActive = false;
        }
        update([]);
        update(reasons);
        setLoading(false);
      }).catchError((onError) {
        setLoading(false);
        setError(onError);
      });
    }).catchError((onError) {
      selectActive = false;
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    _beneficiaryRepository.dispose();
  }
}
