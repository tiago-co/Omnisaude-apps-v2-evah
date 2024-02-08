import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_general/omni_general.dart' show PreferencesModel, ProgramModel, ProgramRepository;
import 'package:omni_general/src/stores/user_store.dart' show UserStore;

// ignore: must_be_immutable
class ProgramStore extends NotifierStore<DioError, List<ProgramModel>> with Disposable {
  final ProgramRepository _repository = Modular.get();
  final ModulesStore modulesStore = Modular.get();
  final UserStore userStore = Modular.get();

  ProgramStore() : super([]);

  Timer? _debounce;

  // ProgramModel get programSelected => userStore.programSelected;
  // bool get canChangeProgram => userStore.oprConfigs.useMultiPrograms;
  // bool get canLeftProgram => userStore.oprConfigs.useLeftProfram;

  Future<void> getPrograms([Map<String, String>? params]) async {
    setLoading(true);
    await _repository.getPrograms(params).then((programs) async {
      programs!.sort((a, b) => a.name!.compareTo(b.name!));
      update(programs);
      final PreferencesModel prefs = PreferencesModel();

      programs.forEach((program) {
        // if (program.id == programSelected.id) {
        // prefs.primaryColor = int.tryParse(
        //   '0xFF${program.enterprise!.primaryColor!}',
        // );
        // }
      });
      // await userStore.setUserPreferences(prefs, userStore.userId);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  Future<void> changeProgramSelected(String id) async {
    setLoading(true);
    await _repository.changeProgramSelected(id).then((program) async {
      await _changeGlobalProgram(program!).then((value) {
        update(List.from(state));
        setLoading(false);
      });
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  Future<void> inactivateProgramSelected(
    Map<String, String> data,
    String id,
  ) async {
    setLoading(true);
    await _repository.inactivateProgramSelected(data, id).then((program) async {
      await _changeGlobalProgram(program!);
      getPrograms();
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> addNewProgram(Map<String, String> data) async {
    setLoading(true);
    await _repository.addNewProgram(data).then((program) async {
      await _changeGlobalProgram(program!);
      getPrograms();
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  Future<void> getProgramParams(String? program) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      final Map<String, String> params = {'nome': program ?? ''};
      await getPrograms(params);
    });
  }

  Future<void> _changeGlobalProgram(ProgramModel program) async {
    final PreferencesModel prefs = PreferencesModel();
    // prefs.primaryColor = int.tryParse(
    //   '0xFF${program.enterprise!.primaryColor!}',
    // );
    // prefs.beneficiary = userStore.beneficiary..programSelected = program;
    // program.currentPhase!.modules!.sort((a, b) => a.name!.compareTo(b.name!));
    // modulesStore.update(program.currentPhase!.modules!);
    // await userStore.setUserPreferences(prefs, userStore.userId);
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
