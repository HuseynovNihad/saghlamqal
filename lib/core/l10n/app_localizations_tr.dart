// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get languageTitle => 'Dil seçimi';

  @override
  String get systemLanguage => 'Sistem dili';

  @override
  String get continueButton => 'Devam et';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageSaveError =>
      'Dil seçimi kaydedilemedi. Lütfen tekrar deneyin';
}
