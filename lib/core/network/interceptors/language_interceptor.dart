import 'dart:ui';

import 'package:dio/dio.dart';

import '../../localization/app_language.dart';
import '../../localization/locale_repository.dart';

class LanguageInterceptor extends Interceptor {
  LanguageInterceptor(this._localeRepository);

  final LocaleRepository _localeRepository;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final savedLanguage = _localeRepository.getSavedLanguage();

    final systemLanguageCode = PlatformDispatcher.instance.locale.languageCode;

    final systemLanguage = AppLanguage.fromCode(systemLanguageCode);

    final language = savedLanguage ?? systemLanguage ?? AppLanguage.az;

    options.headers['Accept-Language'] = language.code;

    handler.next(options);
  }
}
