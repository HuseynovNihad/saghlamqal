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

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsLeft = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

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

  void _verify() {
    if (_otp.length < 6) return;

    if (widget.mode == OtpVerifyMode.register) {
      context.read<AuthBloc>().add(
        VerifyOtpSubmitted(email: widget.email, otp: _otp),
      );
    } else if (widget.mode == OtpVerifyMode.restoreAccount) {
      context.read<AuthBloc>().add(
        VerifyRestoreAccountSubmitted(email: widget.email, otp: _otp),
      );
    } else {
      context.push(
        AppRoutes.newPassword,
        extra: NewPasswordExtra(email: widget.email, otp: _otp),
      );
    }
  }

  void _resend() {
    if (!_canResend) return;

    if (widget.mode == OtpVerifyMode.restoreAccount) {
      context.read<AuthBloc>().add(
        ReactivateAccountRequested(email: widget.email),
      );
    } else {
      context.read<AuthBloc>().add(ResendOtpSubmitted(email: widget.email));
    }

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );
              for (final c in _controllers) {
                c.clear();
              }
              _focusNodes[0].requestFocus();
            } else if (state is AuthOtpResent) {
              CustomSnackBar.show(
                context,
                message: 'Yeni kod göndərildi',
                type: SnackBarType.success,
              );
            } else if (state is AuthAuthenticated) {
              context.go(AppRoutes.home);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: 16.p,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        AppAssets.appLogo.png(width: 75, height: 75),
                        Text("SağlamQal", style: AppTextStyles.h1),
                      ],
                    ),
                    24.hs,
                    Container(
                      padding: 20.p,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: 16.br,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.mode == OtpVerifyMode.register
                                ? "Email Təsdiqləmə"
                                : widget.mode == OtpVerifyMode.restoreAccount
                                ? "Hesab Bərpası" // ✅
                                : "Şifrə Sıfırlama",
                            style: AppTextStyles.h2,
                          ),
                          16.hs,
                          Text(
                            widget.mode == OtpVerifyMode.register
                                ? "Emailinizə göndərilən 6 rəqəmli kodu daxil edin"
                                : widget.mode == OtpVerifyMode.restoreAccount
                                ? "Hesabınızı bərpa etmək üçün emailinizə göndərilən kodu daxil edin" // ✅
                                : "Şifrə sıfırlamaq üçün emailinizə göndərilən kodu daxil edin",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          8.hs,
                          Text(
                            widget.email,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          32.hs,
                          state is AuthLoading
                              ? const CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        style: AppTextStyles.h2,
                                        enabled: state is! AuthLoading,
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
                                        onChanged: (value) =>
                                            _onChanged(value, index),
                                      ),
                                    );
                                  }),
                                ),
                          32.hs,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Kodu almadınız? ",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              _canResend
                                  ? CustomTextButton(
                                      text: "Yenidən göndər",
                                      onPressed: _resend,
                                    )
                                  : Text(
                                      "$_secondsLeft san",
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
}
