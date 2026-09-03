import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/enums/otp_verify_mode.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../../shared/widgets/custom_text_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/name_field.dart';

import 'otp_verify_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _googleInitialized = false;
  bool _googleLoading = false;

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

    FocusScope.of(context).unfocus();

    setState(() {
      _googleLoading = true;
    });

    try {
      await _initializeGoogleSignIn();

      await _googleSignIn.signOut();

      final GoogleSignInAccount account = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication authentication = account.authentication;

      final String? idToken = authentication.idToken;

      log('[GoogleLogin] Account selected: ${account.email}');

      if (idToken == null || idToken.isEmpty) {
        log('[GoogleLogin] ID token is NULL or EMPTY');

        if (!mounted) {
          return;
        }

        CustomSnackBar.show(
          context,
          message: 'Google giriş məlumatları alınmadı',
          type: SnackBarType.error,
        );

        return;
      }

      // ==========================================================
      // GOOGLE ID TOKEN DEBUG
      // ==========================================================

      try {
        final parts = idToken.split('.');

        if (parts.length == 3) {
          final normalizedPayload = base64Url.normalize(parts[1]);

          final decodedPayload = utf8.decode(
            base64Url.decode(normalizedPayload),
          );

          final payload = jsonDecode(decodedPayload) as Map<String, dynamic>;

          log('================ GOOGLE TOKEN ================');
          log('[GoogleLogin] aud: ${payload['aud']}');
          log('[GoogleLogin] iss: ${payload['iss']}');
          log('[GoogleLogin] email: ${payload['email']}');
          log('[GoogleLogin] email_verified: ${payload['email_verified']}');
          log('[GoogleLogin] exp: ${payload['exp']}');
          log('==============================================');
        } else {
          log(
            '[GoogleLogin] Invalid JWT structure. '
            'Parts: ${parts.length}',
          );
        }
      } catch (e, stackTrace) {
        log(
          '[GoogleLogin] Token decode error',
          error: e,
          stackTrace: stackTrace,
        );
      }

      // ==========================================================
      // SEND TOKEN TO BACKEND
      // ==========================================================

      if (!mounted) {
        return;
      }

      log('[GoogleLogin] Sending ID token to backend...');

      context.read<AuthBloc>().add(GoogleLoginSubmitted(idToken: idToken));
    } on GoogleSignInException catch (e) {
      log(
        '[GoogleLogin] GoogleSignInException: '
        '${e.code} | ${e.description}',
      );

      if (!mounted) {
        return;
      }

      if (e.code == GoogleSignInExceptionCode.canceled) {
        log('[GoogleLogin] Login cancelled by user');
        return;
      }

      CustomSnackBar.show(
        context,
        message: 'Google ilə giriş zamanı xəta baş verdi',
        type: SnackBarType.error,
      );
    } catch (e, stackTrace) {
      log('[GoogleLogin] Unexpected error', error: e, stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      CustomSnackBar.show(
        context,
        message: 'Google ilə giriş zamanı xəta baş verdi',
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
  // NORMAL REGISTER
  // ============================================================

  void _register() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    context.read<AuthBloc>().add(
      RegisterSubmitted(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      ),
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

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

            if (state is AuthRegistered) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) {
                  return;
                }

                context.push(
                  AppRoutes.otpVerify,
                  extra: OtpVerifyExtra(
                    email: state.email,
                    mode: OtpVerifyMode.register,
                  ),
                );
              });

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
          },

          // ====================================================
          // BUILDER
          // ====================================================
          builder: (context, state) {
            final bool authLoading = state is AuthLoading;
            final bool anyLoading = authLoading || _googleLoading;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                            // ==================================
                            // NAME
                            // ==================================
                            NameField(
                              firstNameController: _firstNameController,
                              lastNameController: _lastNameController,
                            ),

                            16.hs,

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

                            16.hs,

                            // ==================================
                            // CONFIRM PASSWORD
                            // ==================================
                            CustomTextField(
                              label: 'Şifrəni təsdiqlə',
                              hintText: 'Şifrənizi təkrar daxil edin',
                              controller: _confirmPasswordController,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppValidators.combine(value, [
                                    AppValidators.isNotEmpty,
                                  ]);
                                }

                                if (value != _passwordController.text) {
                                  return 'Şifrələr uyğun deyil';
                                }

                                return null;
                              },
                            ),

                            24.hs,

                            // ==================================
                            // REGISTER BUTTON
                            // ==================================
                            CustomElevatedButton(
                              text: 'Qeydiyyatdan keç',
                              isLoading: authLoading && !_googleLoading,
                              onPressed: anyLoading ? null : _register,
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
                                          12.ws,
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
                            // LOGIN
                            // ==================================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hesabın var? ',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                CustomTextButton(
                                  text: 'Daxil ol',
                                  onPressed: () {
                                    if (anyLoading) {
                                      return;
                                    }

                                    context.pop();
                                  },
                                ),
                              ],
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
