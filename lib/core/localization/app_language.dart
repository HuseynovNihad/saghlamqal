import 'package:flutter/widgets.dart';

enum AppLanguage {
  az('az', 'Azərbaycanca'),
  en('en', 'English'),
  ru('ru', 'Русский'),
  tr('tr', 'Türkçe');

  const AppLanguage(this.code, this.nativeName);

  final String code;
  final String nativeName;

  Locale get locale => Locale(code);

  String get flagAsset => 'assets/images/icons/svg/$code.svg';

  static AppLanguage? fromCode(String? code) {
    for (final language in values) {
      if (language.code == code) {
        return language;
      }
    }

    return null;
  }
}
