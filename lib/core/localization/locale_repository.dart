import 'package:shared_preferences/shared_preferences.dart';

import 'app_language.dart';

class LocaleRepository {
  LocaleRepository(this._preferences);

  final SharedPreferences _preferences;

  static const String _languageKey = 'app_language_code';

  AppLanguage? getSavedLanguage() {
    final code = _preferences.getString(_languageKey);

    return AppLanguage.fromCode(code);
  }

  Future<void> saveLanguage(AppLanguage? language) async {
    final bool success;

    if (language == null) {
      success = await _preferences.remove(_languageKey);
    } else {
      success = await _preferences.setString(_languageKey, language.code);
    }

    if (!success) {
      throw StateError('Could not save language preference.');
    }
  }
}
