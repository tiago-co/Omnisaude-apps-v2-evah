import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error(
        Exception('Serviço de localização está desabilitado'),
      );
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      // return Future.error('Permissões de localização não foram concedidas');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        DioError(
          requestOptions: RequestOptions(path: ''),
          error:
              'Permissões de localização foram permanentemente negadas, não é possivel solictar permissões',
        ),
      );
    }

    return Geolocator.getCurrentPosition();
  }
}
