import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart' show ViaCepModel;
import 'package:omni_general/src/core/repositories/utils_repository.dart';

class ZipCodeStore extends NotifierStore<Exception, ViaCepModel>
    with Disposable {
  final UtilsRepository _repository = UtilsRepository();
  ZipCodeStore() : super(ViaCepModel());

  Future<ViaCepModel> getAddressByCep(String zipCode) async {
    setLoading(true);
    return _repository.getAddressByCep(zipCode).then((address) {
      if (address.zipCode == null) {
        throw Exception();
      }

      update(address);
      setLoading(false);
      return address;
    }).catchError((onError) {
      setLoading(false);
      setError(Exception('CEP não encontrado'));
      throw onError;
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
