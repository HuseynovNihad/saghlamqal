import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/services/water_reminder_service.dart';
import 'presentation/cubit/water_reminder_cubit.dart';

Future<void> initWaterReminder(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // EXTERNAL
  // ─────────────────────────────────────────────────────────────

  if (!sl.isRegistered<FlutterLocalNotificationsPlugin>()) {
    sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
  }

  if (!sl.isRegistered<SharedPreferences>()) {
    final prefs = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(prefs);
  }

  // ─────────────────────────────────────────────────────────────
  // SERVICE
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton(
    () => WaterReminderService(
      notifications: sl<FlutterLocalNotificationsPlugin>(),
      prefs: sl<SharedPreferences>(),
    ),
  );

  await sl<WaterReminderService>().initialize();

  // ─────────────────────────────────────────────────────────────
  // CUBIT
  // ─────────────────────────────────────────────────────────────

  sl.registerFactory(
    () => WaterReminderCubit(service: sl<WaterReminderService>()),
  );
}
