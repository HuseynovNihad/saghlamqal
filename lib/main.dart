import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/localization/locale_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final localeRepository = di.sl<LocaleRepository>();

  runApp(MyApp(localeRepository: localeRepository));
}
