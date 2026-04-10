import 'package:dio/dio.dart';

class NetworkExceptions implements Exception {
  static String handleException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Bağlantı vaxtı bitdi. İnterneti yoxlayın.";
      case DioExceptionType.badResponse:
        final message = error.response?.data['message'];
        return message ?? "Server xətası baş verdi.";
      case DioExceptionType.connectionError:
        return "İnternet bağlantısı yoxdur.";
      default:
        return "Gözlənilməz bir xəta baş verdi.";
    }
  }
}
