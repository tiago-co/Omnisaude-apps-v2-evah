import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/duplicate_ticket_model.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/duplicate_tickets_repository.dart';

class DuplicateTicketsListStore
    extends NotifierStore<Exception, List<DuplicateTicketModel>> {
  final DuplicateTicketsRepository _repository = Modular.get();

  DuplicateTicketsListStore() : super([]);

  Future<void> getDuplicateTicketsList() async {
    setLoading(true);
    await _repository.getDuplicateTicketsList().then(
      (duplicateTicketList) {
        update(duplicateTicketList);
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        setError(onError);
      },
    );
  }
}
