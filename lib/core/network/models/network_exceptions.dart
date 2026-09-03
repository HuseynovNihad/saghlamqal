import 'package:dio/dio.dart';

/// Backend-dən gələn strukturlaşdırılmış xəta.
/// message: istifadəçiyə göstəriləcək mətn
/// errorCode: backend-in göndərdiyi kod (məs. EMAIL_NOT_VERIFIED)
/// extra: errorCode ilə bağlı əlavə sahələr (məs. email)
class AppException implements Exception {
  final String message;
  final String? errorCode;
  final Map<String, dynamic>? extra;

  AppException(this.message, {this.errorCode, this.extra});

  @override
  String toString() => message;
}

class NetworkExceptions {
  static AppException handleException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException("Bağlantı vaxtı bitdi. İnterneti yoxlayın.");

      case DioExceptionType.badResponse:
        final data = error.response?.data;

        if (data is Map) {
          final msg = data['message'];

          // Nested hal: { message: { errorCode, message, email } }
          if (msg is Map) {
            final innerMessage = msg['message'];
            return AppException(
              (innerMessage is String && innerMessage.isNotEmpty)
                  ? innerMessage
                  : "Server xətası baş verdi.",
              errorCode: msg['errorCode']?.toString(),
              extra: Map<String, dynamic>.from(msg),
            );
          }

          // Flat hal: { errorCode, message, email }
          if (data['errorCode'] != null) {
            return AppException(
              (msg is String && msg.isNotEmpty)
                  ? msg
                  : "Server xətası baş verdi.",
              errorCode: data['errorCode']?.toString(),
              extra: Map<String, dynamic>.from(data),
            );
          }

          if (msg is String && msg.isNotEmpty) {
            return AppException(msg);
          }
          if (msg is List && msg.isNotEmpty) {
            return AppException(msg.first.toString());
          }
        }
        return AppException("Server xətası baş verdi.");

      case DioExceptionType.connectionError:
        return AppException("İnternet bağlantısı yoxdur.");

      default:
        return AppException("Gözlənilməz bir xəta baş verdi.");
    }
  }
}