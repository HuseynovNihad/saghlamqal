import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../network/interceptors/log_interceptor.dart';
import '../network/models/network_exceptions.dart';

class GeminiManager {
  late final Dio _dio;

  static const _apiKey = 'API KEY';
  static const _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/';

  GeminiManager() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([if (kDebugMode) AppLogInterceptor()]);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: {'key': _apiKey},
      );
    } on DioException catch (e) {
      throw NetworkExceptions.handleException(e);
    }
  }
}
