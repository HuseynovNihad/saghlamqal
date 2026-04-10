import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppLogInterceptor extends LogInterceptor {
  AppLogInterceptor()
    : super(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
        logPrint: (obj) {
          debugPrint('🌐 API_LOG: $obj');
        },
      );
}
