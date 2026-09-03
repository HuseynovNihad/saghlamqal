import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/enums/otp_verify_mode.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../../shared/widgets/custom_text_button.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import 'new_password_page.dart';

class OtpVerifyExtra {
  final String email;
  final OtpVerifyMode mode;

  const OtpVerifyExtra({required this.email, required this.mode});
}

class OtpVerifyPage extends StatefulWidget {
  final String email;
  final OtpVerifyMode mode;

  const OtpVerifyPage({super.key, required this.email, required this.mode});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;

  int _secondsLeft = 60;

  bool get _canResend => _secondsLeft == 0;

  String get _otp => _controllers.map((controller) => controller.text).join();

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  // ============================================================
  // TIMER
  // ============================================================

  void _startTimer() {
    _secondsLeft = 60;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        return;
      }

      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _secondsLeft--;
      });
    });
  }

  // ============================================================
  // OTP INPUT CHANGE
  // ============================================================

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (_otp.length == 6) {
      _verify();
    }
  }

  // ============================================================
  // VERIFY OTP
  // ============================================================

  void _verify() {
    if (_otp.length != 6) {
      return;
    }

    // ----------------------------------------------------------
    // REGISTER OTP
    // ----------------------------------------------------------

    if (widget.mode == OtpVerifyMode.register) {
      context.read<AuthBloc>().add(
        VerifyOtpSubmitted(email: widget.email, otp: _otp),
      );

      return;
    }

    // ----------------------------------------------------------
    // RESTORE ACCOUNT OTP
    // ----------------------------------------------------------

    if (widget.mode == OtpVerifyMode.restoreAccount) {
      context.read<AuthBloc>().add(
        VerifyRestoreAccountSubmitted(email: widget.email, otp: _otp),
      );

      return;
    }

    // ----------------------------------------------------------
    // RESET PASSWORD OTP
    //
    // Burada backend-ə ayrıca verify request getmir.
    // OTP NewPasswordPage-ə ötürülür və reset-password
    // request zamanı backend tərəfindən yoxlanılır.
    // ----------------------------------------------------------

    if (widget.mode == OtpVerifyMode.resetPassword) {
      context.push(
        AppRoutes.newPassword,
        extra: NewPasswordExtra(email: widget.email, otp: _otp),
      );
    }
  }

  // ============================================================
  // RESEND OTP
  // ============================================================

  void _resend() {
    if (!_canResend) {
      return;
    }

    // ----------------------------------------------------------
    // RESTORE ACCOUNT
    // ----------------------------------------------------------

    if (widget.mode == OtpVerifyMode.restoreAccount) {
      context.read<AuthBloc>().add(
        ReactivateAccountRequested(email: widget.email),
      );

      _startTimer();

      return;
    }

    // ----------------------------------------------------------
    // RESET PASSWORD
    //
    // Reset OTP forgot-password endpoint tərəfindən yaradılır.
    // Ona görə adi resendOtp yox, ForgotPasswordSubmitted
    // istifadə olunmalıdır.
    // ----------------------------------------------------------

    if (widget.mode == OtpVerifyMode.resetPassword) {
      context.read<AuthBloc>().add(
        ForgotPasswordSubmitted(email: widget.email),
      );

      _startTimer();

      return;
    }

    // ----------------------------------------------------------
    // REGISTER
    // ----------------------------------------------------------

    context.read<AuthBloc>().add(ResendOtpSubmitted(email: widget.email));

    _startTimer();
  }

  // ============================================================
  // CLEAR OTP
  // ============================================================

  void _clearOtp() {
    for (final controller in _controllers) {
      controller.clear();
    }

    if (_focusNodes.isNotEmpty) {
      _focusNodes.first.requestFocus();
    }
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _timer?.cancel();

    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          // ====================================================
          // LISTENER
          // ====================================================
          listener: (context, state) {
            // --------------------------------------------------
            // ERROR
            // --------------------------------------------------

            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );

              _clearOtp();

              return;
            }

            // --------------------------------------------------
            // NORMAL OTP RESEND SUCCESS
            // --------------------------------------------------

            if (state is AuthOtpResent) {
              CustomSnackBar.show(
                context,
                message: 'Yeni kod göndərildi',
                type: SnackBarType.success,
              );

              return;
            }

            // --------------------------------------------------
            // RESET PASSWORD OTP RESEND SUCCESS
            // --------------------------------------------------

            if (state is AuthForgotPasswordSent) {
              CustomSnackBar.show(
                context,
                message: 'Yeni kod göndərildi',
                type: SnackBarType.success,
              );

              return;
            }

            // --------------------------------------------------
            // REGISTER / RESTORE SUCCESS
            // --------------------------------------------------

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
            final bool isLoading = state is AuthLoading;

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

                    24.hs,

                    // ==========================================
                    // CONTENT
                    // ==========================================
                    Container(
                      padding: 20.p,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: 16.br,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ====================================
                          // TITLE
                          // ====================================
                          Text(
                            _getTitle(),
                            style: AppTextStyles.h2,
                            textAlign: TextAlign.center,
                          ),

                          16.hs,

                          // ====================================
                          // DESCRIPTION
                          // ====================================
                          Text(
                            _getDescription(),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.grey,
                            ),
                          ),

                          8.hs,

                          // ====================================
                          // EMAIL
                          // ====================================
                          Text(
                            widget.email,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          32.hs,

                          // ====================================
                          // OTP
                          // ====================================
                          if (isLoading)
                            const CircularProgressIndicator()
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(6, (index) {
                                return SizedBox(
                                  width: 48,
                                  height: 56,
                                  child: TextField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    enabled: !isLoading,
                                    style: AppTextStyles.h2,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: 12.br,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: 12.br,
                                        borderSide: const BorderSide(
                                          color: Colors.green,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      _onChanged(value, index);
                                    },
                                  ),
                                );
                              }),
                            ),

                          32.hs,

                          // ====================================
                          // RESEND
                          // ====================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Kodu almadınız? ',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              if (_canResend)
                                CustomTextButton(
                                  text: 'Yenidən göndər',
                                  onPressed: () {
                                    if (isLoading) return;
                                    _resend();
                                  },
                                )
                              else
                                Text(
                                  '$_secondsLeft san',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ],
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

  // ============================================================
  // TITLE
  // ============================================================

  String _getTitle() {
    switch (widget.mode) {
      case OtpVerifyMode.register:
        return 'Email Təsdiqləmə';

      case OtpVerifyMode.resetPassword:
        return 'Şifrə Sıfırlama';

      case OtpVerifyMode.restoreAccount:
        return 'Hesab Bərpası';
    }
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  String _getDescription() {
    switch (widget.mode) {
      case OtpVerifyMode.register:
        return 'Emailinizə göndərilən 6 rəqəmli kodu daxil edin';

      case OtpVerifyMode.resetPassword:
        return 'Şifrənizi yeniləmək üçün emailinizə göndərilən 6 rəqəmli kodu daxil edin';

      case OtpVerifyMode.restoreAccount:
        return 'Hesabınızı bərpa etmək üçün emailinizə göndərilən 6 rəqəmli kodu daxil edin';
    }
  }
}
