import 'package:dio/dio.dart';

class NetworkExceptions implements Exception {
  static String handleException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Bağlantı vaxtı bitdi. İnterneti yoxlayın.";
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        final message = data is Map ? data['message'] : null;

        if (message is String && message.isNotEmpty) {
          return message;
        }
        if (message is List && message.isNotEmpty) {
          return message.first.toString();
        }
        return "Server xətası baş verdi.";
      case DioExceptionType.connectionError:
        return "İnternet bağlantısı yoxdur.";
      default:
        return "Gözlənilməz bir xəta baş verdi.";
    }
  }
}