import 'package:get_it/get_it.dart';
import '../../features/auth/auth_di.dart';
import '../network/network_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- CORE LAYER (Qlobal Servislər) ---
  sl.registerLazySingleton<NetworkManager>(() => NetworkManager());

  // --- FEATURES LAYER (Modul DI-lar) ---
  initAuth();
}
