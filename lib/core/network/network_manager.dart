import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../storage/token_storage.dart';
import '../di/injection_container.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'models/network_exceptions.dart';

class NetworkManager {
  late final Dio _dio;

  NetworkManager() {
    final tokenStorage = sl<TokenStorage>();

    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.saglamqal.az/v1/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(tokenStorage),
      if (kDebugMode) AppLogInterceptor(),
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
      options: Options(contentType: 'multipart/form-data'),
    );
  }
}
