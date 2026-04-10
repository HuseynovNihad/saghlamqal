import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('No route defined for ${state.uri}')),
    ),

    routes: [
      // GoRoute(
      //   path: AppRoutes.login,
      //   name: 'login', // İsteğe bağlı, context.pushNamed üçün
      //   builder: (context, state) => const LoginView(),
      // ),
    ],
  );
}
