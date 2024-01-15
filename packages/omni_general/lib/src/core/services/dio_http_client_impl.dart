import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:omni_general/src/core/services/application_http_client.dart';

class DioHttpClientImpl implements ApplicationHttpClient {
  final Dio _client;

  DioHttpClientImpl(
    this._client,
  );

  @override
  Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    // assert(
    //   path.startsWith('/'),
    //   'Path parameter must start with "/"!',
    // );
    final Response response = await _client.post(
      path,
      data: data,
      options: Options(responseType: ResponseType.json),
    );
    return response;
  }

  @override
  Future<Response> patch({
    required String path,
    dynamic data,
  }) async {
    assert(
      path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    final Response response = await _client.patch(
      path,
      data: data,
    );
    return response;
  }

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? authorization,
  }) async {
    assert(
      path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    final Response response = await _client.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    log(_client.options.baseUrl + path);
    return response;
  }

  @override
  Future<Response> download({
    required String path,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? authorization,
  }) async {
    assert(
      path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    final Response response = await _client.download(
      path,
      savePath,
      queryParameters: queryParameters,
      options: options,
    );
    log(_client.options.baseUrl + path);
    return response;
  }

  @override
  Future<Response> delete({
    required String path,
    String? authorization,
  }) async {
    assert(
      path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    final Response response = await _client.delete(
      path,
    );

    return response;
  }

  @override
  Future<Response> put({
    required String path,
    dynamic data,
    String? authorization,
  }) async {
    assert(
      path.startsWith('/'),
      'Path parameter must start with "/"!',
    );
    final Response response = await _client.put(
      path,
      data: data,
    );
    return response;
  }

  @override
  void setBaseUrl({required String baseUrl}) {
    _client.options.baseUrl = baseUrl;
  }

  @override
  Map<String, dynamic> get getHeaders {
    return _client.options.headers;
  }

  @override
  void setHeaders(Map<String, dynamic> headers) {
    _client.options.headers = headers;
  }
}
