import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../network/interceptors/log_interceptor.dart';
import '../network/models/network_exceptions.dart';

class GeminiManager {
  late final Dio _dio;

  static const _apiKey = 'Token';
  static const _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/';
  static const _maxRetries = 3;
  static const _retryableStatusCodes = [503, 429];

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
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        return await _dio.post<T>(
          path,
          data: data,
          queryParameters: {'key': _apiKey},
        );
      } on DioException catch (e) {
        final statusCode = e.response?.statusCode;
        final isRetryable = _retryableStatusCodes.contains(statusCode);
        final hasMoreAttempts = attempt < _maxRetries;

        if (isRetryable && hasMoreAttempts) {
          await Future.delayed(Duration(seconds: attempt * 2));
          continue;
        }

        throw NetworkExceptions.handleException(e);
      }
    }

    throw NetworkExceptions.handleException(
      DioException(
        requestOptions: RequestOptions(path: path),
        message: 'Xidmət müvəqqəti əlçatmazdır',
      ),
    );
  }
}
