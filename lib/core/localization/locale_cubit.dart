import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_language.dart';
import 'locale_repository.dart';

class LocaleCubit extends Cubit<AppLanguage?> {
  LocaleCubit(this._repository, {Future<void> Function()? onLanguageChanged})
    : _onLanguageChanged = onLanguageChanged,
      super(_repository.getSavedLanguage());

  final LocaleRepository _repository;

  final Future<void> Function()? _onLanguageChanged;

  bool _isSaving = false;

  Future<void> changeLanguage(AppLanguage? language) async {
    if (_isSaving || state == language) {
      return;
    }

    _isSaving = true;

    try {
      await _repository.saveLanguage(language);

      if (!isClosed) {
        emit(language);
      }

      try {
        await _onLanguageChanged?.call();
      } catch (_) {
        // Dil dəyişikliyi notification yenilənməsi
        // uğursuz olsa belə davam etməlidir.
      }
    } finally {
      _isSaving = false;
    }
  }
}
