import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection_container.dart';
import '../../features/ai_photo_scan/presentation/pages/photo_scan_page.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/new_password_page.dart';
import '../../features/auth/presentation/pages/otp_verify_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/favorites/presentation/pages/favorite_page.dart';
import '../../features/home/domain/entities/meal_of_the_day_entity.dart';
import '../../features/home/domain/entities/recent_product_entity.dart';
import '../../features/home/presentation/pages/main_page.dart';
import '../../features/home/presentation/pages/recent_products_page.dart';
import '../../features/home/presentation/pages/recipe_page.dart';
import '../../features/scan/presentation/scan_page.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../../shared/widgets/error_page.dart';
import '../enums/error_type.dart';
import 'app_routes.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static final AuthBloc _authBloc = sl<AuthBloc>()..add(AppStarted());

  static const _authPages = [
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.forgotPassword,
    AppRoutes.resetOtp,
    AppRoutes.newPassword,
    AppRoutes.otpVerify,
  ];

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
    errorBuilder: (context, state) => ErrorPage(
      type: ErrorType.notFound,
      onBack: () => context.go(AppRoutes.home),
    ),

    redirect: (context, state) {
      final authState = _authBloc.state;
      final location = state.matchedLocation;

      if (authState is AuthInitial) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (location == AppRoutes.splash) return AppRoutes.home;

      if (authState is AuthAuthenticated && _authPages.contains(location)) {
        return AppRoutes.home;
      }

      return null;
    },

    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashPage()),

      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) =>
            BlocProvider.value(value: _authBloc, child: const LoginPage()),
      ),

      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) =>
            BlocProvider.value(value: _authBloc, child: const RegisterPage()),
      ),

      GoRoute(
        path: AppRoutes.otpVerify,
        builder: (_, state) {
          final extra = state.extra;
          if (extra is! OtpVerifyExtra) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return BlocProvider.value(
            value: _authBloc,
            child: OtpVerifyPage(email: extra.email, mode: extra.mode),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => BlocProvider.value(
          value: _authBloc,
          child: const ForgotPasswordPage(),
        ),
      ),

      GoRoute(
        path: AppRoutes.resetOtp,
        builder: (_, state) {
          final extra = state.extra;
          if (extra is! String) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return BlocProvider.value(
            value: _authBloc,
            child: OtpVerifyPage(
              email: extra,
              mode: OtpVerifyMode.resetPassword,
            ),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.newPassword,
        builder: (_, state) {
          final extra = state.extra;
          if (extra is! NewPasswordExtra) {
            return const _RedirectingPlaceholder(target: AppRoutes.login);
          }
          return BlocProvider.value(
            value: _authBloc,
            child: NewPasswordPage(email: extra.email, otp: extra.otp),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) =>
            BlocProvider.value(value: _authBloc, child: const MainPage()),
      ),

      GoRoute(path: AppRoutes.scan, builder: (_, __) => const ScanPage()),

      GoRoute(
        path: AppRoutes.favorites,
        builder: (_, __) => const FavoritesPage(),
      ),

      GoRoute(
        path: AppRoutes.recentProducts,
        builder: (_, state) {
          final extra = state.extra;
          if (extra is! List<RecentProductEntity>) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return RecentProductsPage(products: extra);
        },
      ),

      GoRoute(
        path: AppRoutes.photoScan,
        builder: (_, __) => const PhotoScanPage(),
      ),

      GoRoute(
        path: AppRoutes.recipe,
        builder: (_, state) {
          final extra = state.extra;
          if (extra is! MealOfTheDayEntity) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return RecipePage(meal: extra);
        },
      ),
    ],
  );
}

class _RedirectingPlaceholder extends StatefulWidget {
  final String target;
  const _RedirectingPlaceholder({required this.target});

  @override
  State<_RedirectingPlaceholder> createState() =>
      _RedirectingPlaceholderState();
}

class _RedirectingPlaceholderState extends State<_RedirectingPlaceholder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.go(widget.target);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
