import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final String? errorCode;
  final Map<String, dynamic>? extra;
  final int? statusCode;

  AppException(this.message, {this.errorCode, this.extra, this.statusCode});

  @override
  String toString() => message;
}

class NetworkExceptions {
  static AppException handleException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException('Bağlantı vaxtı bitdi. İnterneti yoxlayın.');

      case DioExceptionType.badResponse:
        final data = error.response?.data;
        final statusCode = error.response?.statusCode;

        if (data is Map) {
          final msg = data['message'];

          // Nested hal:
          // { message: { errorCode, message, email } }
          if (msg is Map) {
            final innerMessage = msg['message'];

            return AppException(
              (innerMessage is String && innerMessage.isNotEmpty)
                  ? innerMessage
                  : 'Server xətası baş verdi.',
              errorCode: msg['errorCode']?.toString(),
              extra: Map<String, dynamic>.from(msg),
              statusCode: statusCode,
            );
          }

          // Flat hal:
          // { errorCode, message, email }
          if (data['errorCode'] != null) {
            return AppException(
              (msg is String && msg.isNotEmpty)
                  ? msg
                  : 'Server xətası baş verdi.',
              errorCode: data['errorCode']?.toString(),
              extra: Map<String, dynamic>.from(data),
              statusCode: statusCode,
            );
          }

          if (msg is String && msg.isNotEmpty) {
            return AppException(msg, statusCode: statusCode);
          }

          if (msg is List && msg.isNotEmpty) {
            return AppException(msg.first.toString(), statusCode: statusCode);
          }
        }

        return AppException('Server xətası baş verdi.', statusCode: statusCode);

      case DioExceptionType.connectionError:
        return AppException('İnternet bağlantısı yoxdur.');

      default:
        return AppException('Gözlənilməz bir xəta baş verdi.');
    }
  }
}
