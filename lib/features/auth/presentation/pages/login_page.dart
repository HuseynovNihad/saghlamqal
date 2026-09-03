import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/enums/otp_verify_mode.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../../shared/widgets/custom_text_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import 'otp_verify_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _googleInitialized = false;
  bool _googleLoading = false;

  // ============================================================
  // NORMAL LOGIN
  // ============================================================

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      LoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  // ============================================================
  // GOOGLE INITIALIZATION
  // ============================================================

  Future<void> _initializeGoogleSignIn() async {
    if (_googleInitialized) {
      return;
    }

    await _googleSignIn.initialize(
      serverClientId:
          '849915398868-3b1lhelm7oshclin97mcpji114mjhq3j.apps.googleusercontent.com',
    );

    _googleInitialized = true;
  }

  // ============================================================
  // GOOGLE LOGIN
  // ============================================================

  Future<void> _loginWithGoogle() async {
    if (_googleLoading) {
      return;
    }

    setState(() {
      _googleLoading = true;
    });

    try {
      await _initializeGoogleSignIn();

      await _googleSignIn.signOut();

      final GoogleSignInAccount account = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication authentication = account.authentication;

      final String? idToken = authentication.idToken;

      log('[GoogleLogin] Google account selected: ${account.email}');

      if (idToken == null || idToken.isEmpty) {
        if (!mounted) {
          return;
        }

        CustomSnackBar.show(
          context,
          message: 'Google ID token alınmadı. Yenidən cəhd edin.',
          type: SnackBarType.error,
        );

        return;
      }

      if (!mounted) {
        return;
      }

      context.read<AuthBloc>().add(GoogleLoginSubmitted(idToken: idToken));
    } on GoogleSignInException catch (e) {
      log(
        '[GoogleLogin] GoogleSignInException: '
        '${e.code} | ${e.description}',
      );
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return;
      }

      if (!mounted) {
        return;
      }

      CustomSnackBar.show(
        context,
        message: 'Google ilə giriş mümkün olmadı. Yenidən cəhd edin.',
        type: SnackBarType.error,
      );
    } catch (e, stackTrace) {
      log('[GoogleLogin] Unexpected error', error: e, stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      CustomSnackBar.show(
        context,
        message: 'Google ilə giriş zamanı xəta baş verdi.',
        type: SnackBarType.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _googleLoading = false;
        });
      }
    }
  }

  // ============================================================
  // REACTIVATE ACCOUNT
  // ============================================================

  void _showReactivateDialog(BuildContext context, String email) {
    CustomAlertDialog.show(
      context,
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.warning.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppAssets.lockPerson.svg(
            color: AppColors.warning,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: 'Hesab deaktivdir',
      message:
          'Hesabınız deaktiv edilmişdir. '
          'Yenidən aktivləşdirmək üçün emailinizə '
          'doğrulama kodu göndəriləcək.',
      confirmText: 'Aktivləşdir',
      onConfirm: () {
        context.read<AuthBloc>().add(ReactivateAccountRequested(email: email));
      },
    );
  }

  // ============================================================
  // SET PASSWORD ALERT
  // ============================================================

  void _showPasswordNotSetDialog(BuildContext context, String email) {
    CustomAlertDialog.show(
      context,
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppAssets.lockPerson.svg(
            color: AppColors.primary,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: 'Şifrə təyin edilməyib',
      message:
          'Bu hesab Google ilə yaradılıb. '
          'Email və şifrə ilə daxil olmaq üçün hesabınıza şifrə təyin edin.',
      confirmText: 'Şifrə təyin et',
      onConfirm: () {
        context.read<AuthBloc>().add(ForgotPasswordSubmitted(email: email));
      },
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          // ====================================================
          // LISTENER
          // ====================================================
          listener: (context, state) {
            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );

              return;
            }

            if (state is AuthPasswordNotSet) {
              _showPasswordNotSetDialog(context, state.email);

              return;
            }

            if (state is AuthForgotPasswordSent) {
              context.push(
                AppRoutes.otpVerify,
                extra: OtpVerifyExtra(
                  email: state.email,
                  mode: OtpVerifyMode.resetPassword,
                ),
              );

              return;
            }

            if (state is AuthAuthenticated) {
              if (state.user.profileCompleted) {
                context.go(AppRoutes.home);
              } else {
                context.go(AppRoutes.completeProfile);
              }

              return;
            }

            if (state is AuthAccountDeactivated) {
              _showReactivateDialog(context, state.email);

              return;
            }

            if (state is AuthRestoreOtpSent) {
              context.push(AppRoutes.restoreOtp, extra: state.email);

              return;
            }

            if (state is AuthEmailNotVerified) {
              context.push(
                AppRoutes.otpVerify,
                extra: OtpVerifyExtra(
                  email: state.email,
                  mode: OtpVerifyMode.register,
                ),
              );

              return;
            }
          },

          // ====================================================
          // BUILDER
          // ====================================================
          builder: (context, state) {
            final bool authLoading = state is AuthLoading;

            final bool anyLoading = authLoading || _googleLoading;

            return SingleChildScrollView(
              child: Padding(
                padding: 16.p,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ==========================================
                    // LOGO
                    // ==========================================
                    Column(
                      children: [
                        AppAssets.appLogo.png(width: 75, height: 75),
                        Text('SağlamQal', style: AppTextStyles.h1),
                      ],
                    ),

                    8.hs,

                    Container(
                      padding: 20.p,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Daxil ol', style: AppTextStyles.h2),

                            20.hs,

                            // ==================================
                            // EMAIL
                            // ==================================
                            CustomTextField(
                              label: 'Email',
                              hintText: 'Emailinizi daxil edin',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => AppValidators.combine(
                                value,
                                [AppValidators.isNotEmpty, AppValidators.email],
                              ),
                            ),

                            16.hs,

                            // ==================================
                            // PASSWORD
                            // ==================================
                            CustomTextField(
                              label: 'Şifrə',
                              hintText: 'Şifrənizi daxil edin',
                              controller: _passwordController,
                              isPassword: true,
                              validator: (value) =>
                                  AppValidators.combine(value, [
                                    AppValidators.isNotEmpty,
                                    AppValidators.password,
                                  ]),
                            ),

                            // ==================================
                            // FORGOT PASSWORD
                            // ==================================
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: anyLoading
                                    ? null
                                    : () {
                                        context.push(AppRoutes.forgotPassword);
                                      },
                                child: Text(
                                  'Şifrənizi unutmusunuz?',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),

                            16.hs,

                            // ==================================
                            // NORMAL LOGIN BUTTON
                            // ==================================
                            CustomElevatedButton(
                              text: 'Daxil ol',
                              isLoading: authLoading && !_googleLoading,
                              onPressed: anyLoading ? null : _login,
                            ),

                            20.hs,

                            // ==================================
                            // DIVIDER
                            // ==================================
                            Row(
                              children: [
                                const Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    'və ya',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider(thickness: 1)),
                              ],
                            ),

                            20.hs,

                            // ==================================
                            // GOOGLE BUTTON
                            // ==================================
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: OutlinedButton(
                                onPressed: anyLoading ? null : _loginWithGoogle,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  side: BorderSide(color: Colors.grey.shade300),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: _googleLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppAssets.google.svg(
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(width: 12),

                                          const Text(
                                            'Google ilə davam et',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),

                            20.hs,

                            // ==================================
                            // REGISTER
                            // ==================================
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hesabın yoxdur? ',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomTextButton(
                                    text: 'Qeydiyyat',
                                    onPressed: () {
                                      if (anyLoading) {
                                        return;
                                      }

                                      context.push(AppRoutes.register);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
