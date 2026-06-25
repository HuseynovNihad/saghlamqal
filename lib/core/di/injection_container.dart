import 'package:get_it/get_it.dart';
import 'package:kalori_tracker/features/profile/profile_di.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/ai_photo_scan/photo_scan_di.dart';
import '../../features/auth/auth_di.dart';
import '../../features/favorites/favorite_di.dart';
import '../../features/home/home_di.dart';
import '../../features/scan/scan_di.dart';
import '../../features/water_reminder/water_reminder_di.dart';
import '../network/network_manager.dart';
import '../storage/token_storage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ================= CORE =================
  sl.registerLazySingleton<NetworkManager>(() => NetworkManager());

  // ================= LOCAL STORAGE =================
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(sl()));

  // ================= FEATURES =================
  await initAuth(sl);
  await initHome(sl);
  await initScan(sl);
  await initFavorites(sl);
  await initPhotoScan(sl);
  await initWaterReminder(sl);
  await initProfile(sl);
}
