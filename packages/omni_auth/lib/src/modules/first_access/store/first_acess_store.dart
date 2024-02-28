import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class FirstAcessStore extends NotifierStore<DioError, FirstAcessModel> with Disposable {
  FirstAcessStore() : super(FirstAcessModel());

  final BeneficiaryRepository _repository = Modular.get();
  final PreferencesService preferencesService = PreferencesService();
  FirstAcessType selected = FirstAcessType.whatsApp;
  String? containPhone = null;

  void updateForm(FirstAcessModel form) {
    update(FirstAcessModel.fromJson(form.toJson()));
  }

  String get isCPFOrEmailParam => state.cpfOrEmail!.contains('@') ? 'email' : 'cpf';

  Future<void> verifyUser() async {
    try {
      setLoading(true);
      await _repository.getIndividualPersonByEmailCPF(state.cpfOrEmail!, isCPFOrEmailParam).then((user) {
        debugger();
        state.id = user.id!;
        if (user.isCompleted == false) {
          containPhone = user.phone;
          Modular.to.pushNamed('./firstAcessForm', arguments: {'id': user.id});
        } else {
          setLoading(false);
          setError(
            DioError(
              requestOptions: RequestOptions(path: ''),
              response: Response(
                statusCode: 403,
                requestOptions: RequestOptions(path: ''),
              ),
            ),
          );
        }
      }).catchError((onError) {
        setLoading(false);
        setError(
          DioError(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
          ),
        );
      });
    } on Exception catch (e) {
      // TODO
      setLoading(false);
    } finally {
      setLoading(false);
    }
  }

  Future sendActivationLink() async {
    try {
      setLoading(true);
      await Future.delayed(Duration(seconds: 2));
      await _repository.sendActivationLink(state.sendTo!, state.id!).then((user) {
        Modular.to.pushNamed('/auth/newLogin');
        setLoading(false);
      }).catchError((onError) {
        throw onError;
      });
    } on DioError catch (e) {
      log('##### sendActivationLink: $e');
      rethrow;
    } on Exception catch (e) {
      log('##### sendActivationLink: $e');
    } finally {
      setLoading(false);
    }
  }

  bool get isDisabled {
    return state.cpfOrEmail == null || (state.cpfOrEmail != null && state.cpfOrEmail!.length < 3);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
