import 'dart:ui';

import 'package:dio/dio.dart';

import '../../l10n/app_localizations.dart';

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
  static const Set<String> _supportedLanguages = {'az', 'en', 'ru', 'tr'};

  static AppException handleException(DioException error) {
    final l10n = _resolveLocalizations(error);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(l10n.networkTimeoutError);

      case DioExceptionType.badResponse:
        final data = error.response?.data;
        final statusCode = error.response?.statusCode;

        if (data is Map) {
          final msg = data['message'];

          // Nested response:
          // {
          //   message: {
          //     errorCode,
          //     message,
          //     email
          //   }
          // }
          if (msg is Map) {
            final innerMessage = msg['message'];

            return AppException(
              innerMessage is String && innerMessage.trim().isNotEmpty
                  ? innerMessage.trim()
                  : l10n.networkServerError,
              errorCode: msg['errorCode']?.toString(),
              extra: Map<String, dynamic>.from(msg),
              statusCode: statusCode,
            );
          }

          // Flat response:
          // {
          //   errorCode,
          //   message,
          //   email
          // }
          if (data['errorCode'] != null) {
            return AppException(
              msg is String && msg.trim().isNotEmpty
                  ? msg.trim()
                  : l10n.networkServerError,
              errorCode: data['errorCode']?.toString(),
              extra: Map<String, dynamic>.from(data),
              statusCode: statusCode,
            );
          }

          if (msg is String && msg.trim().isNotEmpty) {
            return AppException(msg.trim(), statusCode: statusCode);
          }

          if (msg is List && msg.isNotEmpty) {
            return AppException(msg.first.toString(), statusCode: statusCode);
          }
        }

        return AppException(l10n.networkServerError, statusCode: statusCode);

      case DioExceptionType.connectionError:
        return AppException(l10n.networkNoConnectionError);

      default:
        return AppException(l10n.networkUnexpectedError);
    }
  }

  static AppLocalizations _resolveLocalizations(DioException error) {
    final headerLanguage = _extractLanguageCode(
      error.requestOptions.headers['Accept-Language']?.toString(),
    );

    final lowercaseHeaderLanguage = _extractLanguageCode(
      error.requestOptions.headers['accept-language']?.toString(),
    );

    final systemLanguage = PlatformDispatcher.instance.locale.languageCode
        .toLowerCase();

    final requestedLanguage =
        headerLanguage ?? lowercaseHeaderLanguage ?? systemLanguage;

    final languageCode = _supportedLanguages.contains(requestedLanguage)
        ? requestedLanguage
        : 'az';

    return lookupAppLocalizations(Locale(languageCode));
  }

  static String? _extractLanguageCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final firstLanguage = value.split(',').first.trim().split(';').first.trim();

    if (firstLanguage.isEmpty) {
      return null;
    }

    return firstLanguage.split(RegExp('[-_]')).first.toLowerCase();
  }
}
