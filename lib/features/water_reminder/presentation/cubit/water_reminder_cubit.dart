import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/water_reminder_service.dart';
import 'water_reminder_state.dart';

class WaterReminderCubit extends Cubit<WaterReminderState> {
  final WaterReminderService _service;

  WaterReminderCubit({required WaterReminderService service})
    : _service = service,
      super(const WaterReminderState()) {
    _load();
  }

  Future<void> _load() async {
    final enabled = await _service.isEnabled();
    emit(state.copyWith(isEnabled: enabled));
  }

  Future<void> toggle(bool value) async {
    if (value) {
      final granted = await _service.requestPermission();
      if (!granted) {
        emit(state.copyWith(permissionDenied: true));
        return;
      }
    }
    await _service.setEnabled(value);
    emit(state.copyWith(isEnabled: value, permissionDenied: false));
  }
}
