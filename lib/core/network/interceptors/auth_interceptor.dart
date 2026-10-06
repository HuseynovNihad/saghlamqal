import 'package:dio/dio.dart';

import '../../config/app_config.dart';
import '../../storage/token_storage.dart';
import '../endpoints.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  Future<String>? _refreshFuture;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode != 401) {
      return handler.next(err);
    }

    // Login, register və s. kimi Authorization header-i olmayan
    // request-lərdə token refresh etməyə çalışmırıq.
    final authorization = err.requestOptions.headers['Authorization'];

    if (authorization == null) {
      return handler.next(err);
    }

    final refreshToken = _tokenStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await _tokenStorage.clearAll();
      return handler.next(err);
    }

    final language = err.requestOptions.headers['Accept-Language']?.toString();

    final refreshFuture = _refreshFuture ??= _refreshAccessToken(
      refreshToken: refreshToken,
      language: language,
    );

    try {
      final newAccessToken = await refreshFuture;

      // Original request-dəki bütün məlumatlar saxlanılır:
      // Accept-Language
      // query parameters
      // body
      // content-type və s.
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

      final retryDio = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );

      final response = await retryDio.fetch<dynamic>(err.requestOptions);

      return handler.resolve(response);
    } catch (_) {
      await _tokenStorage.clearAll();

      return handler.next(err);
    } finally {
      // Eyni refresh Future-dan istifadə edən paralel request-lərin
      // yeni refresh prosesini səhvən sıfırlamaması üçün.
      if (identical(_refreshFuture, refreshFuture)) {
        _refreshFuture = null;
      }
    }
  }

  Future<String> _refreshAccessToken({
    required String refreshToken,
    String? language,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (language != null && language.isNotEmpty)
            'Accept-Language': language,
        },
      ),
    );

    final response = await dio.post<Map<String, dynamic>>(
      Endpoints.refresh,
      data: {'refreshToken': refreshToken},
    );

    final data = response.data;

    if (data == null) {
      throw StateError('Refresh token response is empty.');
    }

    final accessToken = data['accessToken']?.toString();

    final newRefreshToken = data['refreshToken']?.toString();

    if (accessToken == null || accessToken.isEmpty) {
      throw StateError('Access token is missing from refresh response.');
    }

    await _tokenStorage.saveToken(accessToken);

    if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
      await _tokenStorage.saveRefreshToken(newRefreshToken);
    }

    return accessToken;
  }
}
