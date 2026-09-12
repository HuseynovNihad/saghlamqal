import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection_container.dart';
import '../../features/ai_photo_scan/presentation/pages/photo_scan_page.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/complete_profile_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/new_password_page.dart';
import '../../features/auth/presentation/pages/otp_verify_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../../features/favorites/presentation/pages/favorite_page.dart';
import '../../features/home/domain/entities/meal_of_the_day_entity.dart';
import '../../features/home/domain/entities/recent_product_entity.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/home/presentation/pages/main_page.dart';
import '../../features/home/presentation/pages/recent_products_page.dart';
import '../../features/home/presentation/pages/recipe_page.dart';
import '../../features/onboard/screen/onboarding_screen.dart';
import '../../features/profile/presentation/pages/about_us_page.dart';
import '../../features/profile/presentation/pages/patient_code_page.dart';
import '../../features/profile/presentation/pages/profile_edit_page.dart';
import '../../features/profile/presentation/pages/terms_page.dart';
import '../../features/scan/presentation/scan_page.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../../shared/widgets/error_page.dart';

import '../enums/error_type.dart';
import '../enums/otp_verify_mode.dart';
import '../enums/terms_type.dart';
import '../storage/onboarding_storage.dart';
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
  static final AuthBloc authBloc = sl<AuthBloc>()..add(AppStarted());

  static final HomeBloc homeBloc = sl<HomeBloc>();

  static final FavoritesBloc favoritesBloc = sl<FavoritesBloc>();

  static final OnboardingStorage _onboardingStorage = sl<OnboardingStorage>();

  static const _authPages = [
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.forgotPassword,
    AppRoutes.resetOtp,
    AppRoutes.newPassword,
    AppRoutes.otpVerify,
    AppRoutes.restoreOtp,
  ];

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,

    debugLogDiagnostics: false,

    // Router yalnız session statusuna təsir edən
    // state-lərdə refresh olunur.
    //
    // AuthLoading / AuthError / AuthOtpResent kimi
    // state-lər router-i refresh etmir.
    refreshListenable: GoRouterRefreshStream(
      authBloc.stream.where(
        (state) =>
            state is AuthInitial ||
            state is AuthSessionLoading ||
            state is AuthAuthenticated ||
            state is AuthUnauthenticated,
      ),
    ),

    errorBuilder: (context, state) {
      return ErrorPage(
        type: ErrorType.notFound,
        onBack: () {
          context.go(AppRoutes.home);
        },
      );
    },

    // ==========================================================
    // REDIRECT
    // ==========================================================
    redirect: (context, state) {
      final authState = authBloc.state;
      final location = state.matchedLocation;

      // ========================================================
      // 1. SESSION HƏLƏ YOXLANDIĞI MÜDDƏTDƏ SPLASH
      // ========================================================

      if (authState is AuthInitial || authState is AuthSessionLoading) {
        if (location == AppRoutes.splash) {
          return null;
        }

        return AppRoutes.splash;
      }

      // ========================================================
      // 2. LOGIN OLUNMUŞ USER
      //
      // ÇOX VACİB:
      // Bu yoxlama splash yoxlamasından ƏVVƏL olmalıdır.
      // ========================================================

      if (authState is AuthAuthenticated) {
        final user = authState.user;

        final isProfileCompleted = user.profileCompleted;

        // ------------------------------------------------------
        // PROFİL TAMAMLANMAYIB
        // ------------------------------------------------------

        if (!isProfileCompleted) {
          // Artıq complete profile səhifəsindəyiksə,
          // redirect etmə.
          if (location == AppRoutes.completeProfile) {
            return null;
          }

          // User harada olursa olsun,
          // profil tamamlanana qədər buraya göndər.
          return AppRoutes.completeProfile;
        }

        // ------------------------------------------------------
        // PROFİL TAMAMLANIB
        // ------------------------------------------------------

        // App təzə açılıb və splash-dadırsa
        if (location == AppRoutes.splash) {
          return AppRoutes.home;
        }

        // Profil tamamlanıbsa complete-profile-a
        // yenidən girməsinə icazə vermə.
        if (location == AppRoutes.completeProfile) {
          return AppRoutes.home;
        }

        // Login olmuş user auth səhifələrinə
        // keçməyə çalışırsa Home-a göndər.
        if (_authPages.contains(location)) {
          return AppRoutes.home;
        }

        return null;
      }

      // ========================================================
      // 3. LOGIN OLMAYAN USER
      // ========================================================

      if (authState is AuthUnauthenticated) {
        if (location == AppRoutes.splash) {
          return _onboardingStorage.isCompleted()
              ? AppRoutes.home
              : AppRoutes.onboarding;
        }

        return null;
      }

      return null;
    },

    // ==========================================================
    // ROUTES
    // ==========================================================
    routes: [
      // ========================================================
      // SPLASH
      // ========================================================
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashPage()),

      // ========================================================
      // ONBOARDING
      // ========================================================
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) {
          return OnboardingScreen(
            onFinish: () async {
              await _onboardingStorage.markCompleted();

              router.go(AppRoutes.home);
            },
          );
        },
      ),

      // ========================================================
      // LOGIN
      // ========================================================
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginPage()),

      // ========================================================
      // REGISTER
      // ========================================================
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterPage(),
      ),

      // ========================================================
      // COMPLETE PROFILE
      // ========================================================
      GoRoute(
        path: AppRoutes.completeProfile,
        builder: (_, __) => const CompleteProfilePage(),
      ),

      // ========================================================
      // OTP VERIFY
      // ========================================================
      GoRoute(
        path: AppRoutes.otpVerify,
        builder: (_, state) {
          final extra = state.extra;

          if (extra is! OtpVerifyExtra) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return OtpVerifyPage(email: extra.email, mode: extra.mode);
        },
      ),

      // ========================================================
      // FORGOT PASSWORD
      // ========================================================
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),

      // ========================================================
      // RESET OTP
      // ========================================================
      GoRoute(
        path: AppRoutes.resetOtp,
        builder: (_, state) {
          final extra = state.extra;

          if (extra is! String) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return OtpVerifyPage(email: extra, mode: OtpVerifyMode.resetPassword);
        },
      ),

      // ========================================================
      // NEW PASSWORD
      // ========================================================
      GoRoute(
        path: AppRoutes.newPassword,
        builder: (_, state) {
          final extra = state.extra;

          if (extra is! NewPasswordExtra) {
            return const _RedirectingPlaceholder(target: AppRoutes.login);
          }

          return NewPasswordPage(email: extra.email, otp: extra.otp);
        },
      ),

      // ========================================================
      // RESTORE OTP
      // ========================================================
      GoRoute(
        path: AppRoutes.restoreOtp,
        builder: (_, state) {
          final extra = state.extra;

          if (extra is! String) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return OtpVerifyPage(
            email: extra,
            mode: OtpVerifyMode.restoreAccount,
          );
        },
      ),

      // ========================================================
      // HOME
      // ========================================================
      GoRoute(path: AppRoutes.home, builder: (_, __) => const MainPage()),

      // ========================================================
      // SCAN
      // ========================================================
      GoRoute(path: AppRoutes.scan, builder: (_, __) => const ScanPage()),

      // ========================================================
      // FAVORITES
      // ========================================================
      GoRoute(
        path: AppRoutes.favorites,
        builder: (_, __) => const FavoritesPage(),
      ),

      // ========================================================
      // RECENT PRODUCTS
      // ========================================================
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

      // ========================================================
      // PHOTO SCAN
      // ========================================================
      GoRoute(
        path: AppRoutes.photoScan,
        builder: (_, __) => const PhotoScanPage(),
      ),

      // ========================================================
      // RECIPE
      // ========================================================
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

      // ========================================================
      // TERMS
      // ========================================================
      GoRoute(
        path: AppRoutes.termsOfService,
        builder: (_, __) {
          return const TermsPage(type: TermsType.termsOfService);
        },
      ),

      // ========================================================
      // PRIVACY
      // ========================================================
      GoRoute(
        path: AppRoutes.privacyPolicy,
        builder: (_, __) {
          return const TermsPage(type: TermsType.privacyPolicy);
        },
      ),

      // ========================================================
      // ABOUT US
      // ========================================================
      GoRoute(path: AppRoutes.aboutUs, builder: (_, __) => const AboutUsPage()),

      // ========================================================
      // PROFILE EDIT
      // ========================================================
      GoRoute(
        path: AppRoutes.profileEdit,
        builder: (_, __) {
          return BlocProvider.value(
            value: homeBloc,
            child: const ProfileEditPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.patientCode,
        builder: (_, __) => const PatientCodePage(),
      ),
    ],
  );
}

// ============================================================
// REDIRECT PLACEHOLDER
// ============================================================

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
      if (!mounted) {
        return;
      }

      context.go(widget.target);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
