import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';

// ignore: must_be_immutable
class AddProgramStore extends NotifierStore<Exception, String> {
  final ProgramStore programStore = Modular.get();

  AddProgramStore() : super('');

  bool checkBoxValue = false;

  bool get isDisabled => state.isEmpty || !checkBoxValue;

  void onChangeCheckBoxValue(bool? value) {
    setLoading(true);
    checkBoxValue = value ?? checkBoxValue;
    setLoading(false);
  }

  void onChangeTextFieldValue(String? code) {
    update(code ?? '');
  }

  Future<void> addNewProgram(Map<String, String> data) async {
    setLoading(true);
    await programStore.addNewProgram(data).then((modules) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }
}
