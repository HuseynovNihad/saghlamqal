import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'interceptors/log_interceptor.dart';

class OpenFoodFactsManager {
  late final Dio _dio;

  OpenFoodFactsManager() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://world.openfoodfacts.org/api/v0/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'SaglamQal - Flutter - 1.0',
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(AppLogInterceptor());
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Bağlantı vaxtı bitdi.');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('İnternet bağlantısı yoxdur.');
      }
      rethrow;
    }
  }
}
