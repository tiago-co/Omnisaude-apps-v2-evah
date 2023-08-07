abstract class ApplicationHttpClient {
  Future<dynamic> post({
    required String path,
    required dynamic data,
    String? authorization,
  });

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  });

  Future<dynamic> download({
    required String path,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  });

  Future<dynamic> delete({
    required String path,
    String? authorization,
  });

  Future<dynamic> put({
    required String path,
    required dynamic data,
    String? authorization,
  });

  Future<dynamic> patch({
    required String path,
    required dynamic data,
    // String? authorization,
  });

  void setBaseUrl({
    required String baseUrl,
  });

  Map<String, dynamic> get getHeaders;

  void setHeaders(Map<String, dynamic> headers);
}
