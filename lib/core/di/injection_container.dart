import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/auth_di.dart';
import '../../features/scan/scan_di.dart';
import '../network/network_manager.dart';
import '../storage/token_storage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ================= CORE =================
  sl.registerLazySingleton<NetworkManager>(() => NetworkManager());

  // ================= LOCAL STORAGE =================

  // SharedPreferences init
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // Token storage
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(sl()));

  // ================= FEATURES =================
  await initAuth(sl);
  await initScan(sl);
}
