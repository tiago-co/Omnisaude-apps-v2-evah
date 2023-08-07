import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

class ChatAppointmentRepository extends Disposable {
  final DioHttpClientImpl client;
  ChatAppointmentRepository(
    this.client,
  );

  Future<String> uploadFile(String file) async {
    try {
      final response = await client.post(
        path: '/arquivo/',
        data: {'b64': file},
      );
      return response.data['url'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
