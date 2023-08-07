import 'package:flutter_triple/flutter_triple.dart';

class ReimbursermentTermsCheckStore extends NotifierStore<Exception, bool> {
  ReimbursermentTermsCheckStore() : super(false);

  void updateValue(bool value) {
    setLoading(true);
    update(value);
    setLoading(false);
  }

  void reset() {
    update(false);
  }
}
