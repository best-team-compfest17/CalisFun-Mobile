// lib/src/network/dio_client.dart
import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
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
      ..options.responseType = ResponseType.json;

    // (opsional) terima self-signed; hapus di production bila tak perlu
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate _, String __, int ___) => true;
      return client;
    };

    // logging
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        logPrint: (o) => log(o.toString()),
        requestBody: false,
      ));
    }

    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  Dio get raw => _dio;

  void setBearer(String? token) {
    _dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
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
