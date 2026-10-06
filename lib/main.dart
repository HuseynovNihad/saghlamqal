import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/localization/locale_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final preferences = await SharedPreferences.getInstance();
  final localeRepository = LocaleRepository(preferences);

  runApp(MyApp(localeRepository: localeRepository));
}
