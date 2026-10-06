import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_language.dart';
import 'locale_repository.dart';

class LocaleCubit extends Cubit<AppLanguage?> {
  LocaleCubit(this._repository) : super(_repository.getSavedLanguage());

  final LocaleRepository _repository;

  bool _isSaving = false;

  Future<void> changeLanguage(AppLanguage? language) async {
    if (_isSaving || state == language) return;

    _isSaving = true;

    try {
      await _repository.saveLanguage(language);

      if (!isClosed) {
        emit(language);
      }
    } finally {
      _isSaving = false;
    }
  }
}
