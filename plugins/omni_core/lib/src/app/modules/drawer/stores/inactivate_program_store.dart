import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';

// ignore: must_be_immutable
class InactivateProgramStore extends NotifierStore<Exception, String> {
  final ProgramStore programStore = Modular.get();

  InactivateProgramStore() : super('');

  bool checkBoxValue = false;

  bool get isDisabled => state.isEmpty || !checkBoxValue;

  void onChangeCheckBoxValue(bool? value) {
    setLoading(true);
    checkBoxValue = value ?? checkBoxValue;
    setLoading(false);
  }

  void onChangeTextFieldValue(String? reason) {
    update(reason ?? '');
  }

  Future<void> inactivateProgramSelected(
    Map<String, String> data,
    String id,
  ) async {
    setLoading(true);
    await programStore.inactivateProgramSelected(data, id).then((program) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }
}
