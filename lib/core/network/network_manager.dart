import 'dart:developer';

import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import '../di/injection_container.dart';

import 'interceptors/auth_interceptor.dart';
import 'models/network_exceptions.dart';

class NetworkManager {
  late final Dio _dio;

  NetworkManager() {
    final tokenStorage = sl<TokenStorage>();

    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,

        // Debug üçün bir az artırırıq.
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(tokenStorage),
      // if (kDebugMode) AppLogInterceptor(),
    ]);
  }

  Future<Response<T>> request<T>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(method: method),
      );
    } on DioException catch (e) {
      log('================ DIO ERROR ================');
      log('[NetworkManager] Type: ${e.type}');
      log('[NetworkManager] Method: ${e.requestOptions.method}');
      log('[NetworkManager] URL: ${e.requestOptions.uri}');
      log('[NetworkManager] Status Code: ${e.response?.statusCode}');
      log('[NetworkManager] Message: ${e.message}');
      log('[NetworkManager] Response: ${e.response?.data}');
      log('[NetworkManager] Error: ${e.error}');
      log('===========================================');

      throw NetworkExceptions.handleException(e);
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => request<T>(path, method: 'GET', queryParameters: queryParameters);

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) => request<T>(
    path,
    method: 'POST',
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) => request<T>(
    path,
    method: 'PUT',
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) => request<T>(
    path,
    method: 'PATCH',
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) => request<T>(
    path,
    method: 'DELETE',
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response<T>> uploadFile<T>(String path, FormData formData) {
    return request<T>(
      path,
      method: 'POST',
      data: formData,
      options: Options(method: 'POST', contentType: 'multipart/form-data'),
    );
  }
}
