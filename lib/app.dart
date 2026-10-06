import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_colors.dart';
import 'core/l10n/app_localizations.dart';
import 'core/localization/app_language.dart';
import 'core/localization/locale_cubit.dart';
import 'core/localization/locale_repository.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.localeRepository});

  final LocaleRepository localeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: AppRouter.authBloc),
        BlocProvider<FavoritesBloc>.value(value: AppRouter.favoritesBloc),
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit(localeRepository)),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LocaleCubit, AppLanguage?>(
            builder: (context, language) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'SağlamQal',
                routerConfig: AppRouter.router,

                locale: language?.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,

                localeListResolutionCallback:
                    (deviceLocales, supportedLocales) {
                      for (final deviceLocale
                          in deviceLocales ?? const <Locale>[]) {
                        for (final supportedLocale in supportedLocales) {
                          if (deviceLocale.languageCode ==
                              supportedLocale.languageCode) {
                            return supportedLocale;
                          }
                        }
                      }

                      return const Locale('az');
                    },

                theme: ThemeData(
                  useMaterial3: true,
                  scaffoldBackgroundColor: AppColors.background,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColors.primary,
                    surface: AppColors.surface,
                    background: AppColors.background,
                  ),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    iconTheme: IconThemeData(color: AppColors.headline),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
