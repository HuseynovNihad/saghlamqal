import 'package:dio/dio.dart';

class AppLogInterceptor extends LogInterceptor {
  AppLogInterceptor()
    : super(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
      );
}
