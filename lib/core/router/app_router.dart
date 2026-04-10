import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection_container.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/splash/presentation/splash_page.dart';
import 'app_routes.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static final AuthBloc _authBloc = sl<AuthBloc>()..add(AppStarted());

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    refreshListenable: GoRouterRefreshStream(_authBloc.stream),

    redirect: (context, state) {
      final authState = _authBloc.state;

      final isLoggedIn = authState is AuthAuthenticated;
      final isLoading = authState is AuthInitial || authState is AuthLoading;

      final location = state.matchedLocation;

      if (isLoading) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (!isLoggedIn) {
        final allowedRoutes = [AppRoutes.login, AppRoutes.register];
        return allowedRoutes.contains(location) ? null : AppRoutes.login;
      }

      if (location == AppRoutes.login ||
          location == AppRoutes.register ||
          location == AppRoutes.splash) {
        return AppRoutes.home;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return BlocProvider.value(value: _authBloc, child: const LoginPage());
        },
      ),

      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) {
          return BlocProvider.value(
            value: _authBloc,
            child: const RegisterPage(),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          return const Scaffold(body: Center(child: Text("Home")));
        },
      ),
    ],
  );
}
