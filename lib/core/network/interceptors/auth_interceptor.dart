import 'package:dio/dio.dart';
import '../../../core/network/endpoints.dart';
import '../../../core/storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  bool _isRefreshing = false;

  AuthInterceptor(this._tokenStorage);

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
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final refreshToken = _tokenStorage.getRefreshToken();
        if (refreshToken == null) {
          await _tokenStorage.clearAll();
          _isRefreshing = false;
          return handler.next(err);
        }

        final dio = Dio(BaseOptions(baseUrl: 'http://13.140.157.103/'));
        final response = await dio.post(
          Endpoints.refresh,
          data: {'refreshToken': refreshToken},
        );

        final newAccessToken = response.data['accessToken'] as String;
        final newRefreshToken = response.data['refreshToken'] as String;

        await _tokenStorage.saveToken(newAccessToken);
        await _tokenStorage.saveRefreshToken(newRefreshToken);

        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retried = await dio.fetch(err.requestOptions);

        _isRefreshing = false;
        return handler.resolve(retried);
      } catch (_) {
        await _tokenStorage.clearAll();
        _isRefreshing = false;
      }
    }

    handler.next(err);
  }
}
