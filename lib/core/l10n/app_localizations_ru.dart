// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get languageTitle => 'Выбор языка';

  @override
  String get systemLanguage => 'Язык системы';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get languageSaveError =>
      'Не удалось сохранить язык. Попробуйте ещё раз';
}
