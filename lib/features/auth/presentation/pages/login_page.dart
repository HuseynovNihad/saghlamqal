import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      LoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

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
      title: "Hesab deaktivdir",
      message:
          "Hesabınız deaktiv edilmişdir. Yenidən aktivləşdirmək üçün emailinizə doğrulama kodu göndəriləcək.",
      confirmText: "Aktivləşdir",
      onConfirm: () => context.read<AuthBloc>().add(
        ReactivateAccountRequested(email: email),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );
            } else if (state is AuthAuthenticated) {
              context.go(AppRoutes.home);
            } else if (state is AuthAccountDeactivated) {
              _showReactivateDialog(context, state.email);
            } else if (state is AuthRestoreOtpSent) {
              context.push(AppRoutes.restoreOtp, extra: state.email);
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
                    8.hs,
                    Container(
                      padding: 20.p,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Daxil ol", style: AppTextStyles.h2),
                            20.hs,
                            CustomTextField(
                              label: "Email",
                              hintText: "Emailnizi daxil edin",
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => AppValidators.combine(
                                value,
                                [AppValidators.isNotEmpty, AppValidators.email],
                              ),
                            ),
                            16.hs,
                            CustomTextField(
                              label: "Şifrə",
                              hintText: "Şifrənizi daxil edin",
                              controller: _passwordController,
                              isPassword: true,
                              validator: (value) =>
                                  AppValidators.combine(value, [
                                    AppValidators.isNotEmpty,
                                    AppValidators.password,
                                  ]),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  context.go(AppRoutes.forgotPassword);
                                },
                                child: Text(
                                  "Şifrənizi unutmusunuz?",
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            16.hs,
                            CustomElevatedButton(
                              text: "Daxil ol",
                              isLoading: state is AuthLoading,
                              onPressed: _login,
                            ),
                            12.hs,
                            Row(
                              children: [
                                Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text("və ya"),
                                ),
                                Expanded(child: Divider(thickness: 1)),
                              ],
                            ),
                            12.hs,
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Hesabın yoxdur? ",
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomTextButton(
                                    text: "Qeydiyyat",
                                    onPressed: () {
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          "Sağlam həyat sənin əlindədir 💚",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
        ),
      ),
    );
  }
}
