import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _connectTimeout = Duration(seconds: 60);
const _receiveTimeout = Duration(seconds: 60);

class DioClient {
  final String baseUrl;
  late final Dio _dio;

  DioClient({
    required Dio dio,
    required HttpClient httpClient,
    required this.baseUrl,
    List<Interceptor>? interceptors,
  }) {
    _dio = dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _connectTimeout
      ..options.receiveTimeout = _receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

    ( _dio.httpClientAdapter as IOHttpClientAdapter ).createHttpClient = () {
      final client = httpClient;
      client.badCertificateCallback =
          (X509Certificate _, String __, int ___) => true;
      return client;
    };

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (o) => log(o.toString()),
    ));

    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  Dio get raw => _dio;

  Future<void> useToken(String? token) async {
    final headers = Map<String, dynamic>.from(_dio.options.headers);
    if (token == null || token.isEmpty) {
      headers.remove('Authorization');
    } else {
      headers['Authorization'] = 'Bearer $token';
    }
    _dio.options.headers = headers;
  }

  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    final res = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return res.data;
  }

  Future<dynamic> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    final res = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return res.data;
  }

  Future<dynamic> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    final res = await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return res.data;
  }

  Future<dynamic> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    final res = await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return res.data;
  }

  void setHeader(String key, dynamic value) {
    final headers = Map<String, dynamic>.from(_dio.options.headers);
    if (value == null) {
      headers.remove(key);
    } else {
      headers[key] = value;
    }
    _dio.options.headers = headers;
  }
}

final dioClientProvider = Provider<DioClient>((ref) {
  final baseUrl = dotenv.get('API_URL');
  return DioClient(
    dio: Dio(),
    httpClient: HttpClient(),
    baseUrl: baseUrl,
  );
});
