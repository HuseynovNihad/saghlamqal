import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../../shared/widgets/custom_text_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class NewPasswordExtra {
  final String email;
  final String otp;

  const NewPasswordExtra({required this.email, required this.otp});
}

class NewPasswordPage extends StatefulWidget {
  final String email;
  final String otp;

  const NewPasswordPage({super.key, required this.email, required this.otp});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _newPasswordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      ResetPasswordSubmitted(
        email: widget.email,
        otp: widget.otp,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            log(
              '📍 NewPasswordPage listener | '
              'state=${state.runtimeType}',
            );

            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );

              return;
            }

            if (state is AuthPasswordResetSuccess) {
              log(
                '📍 AuthPasswordResetSuccess alındı, '
                'login-ə keçid planlaşdırılır',
              );

              CustomSnackBar.show(
                context,
                message: context.l10n.authPasswordResetSuccess,
                type: SnackBarType.success,
              );

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) {
                  return;
                }

                context.read<AuthBloc>().add(const AuthStateReset());

                context.go(AppRoutes.login);
              });
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              child: Padding(
                padding: 16.p,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ==============================
                      // LOGO
                      // ==============================
                      Column(
                        children: [
                          AppAssets.appLogo.png(width: 75, height: 75),
                          Text('SağlamQal', style: AppTextStyles.h1),
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
                            // ==========================
                            // TITLE
                            // ==========================
                            Text(
                              context.l10n.authNewPasswordTitle,
                              style: AppTextStyles.h2,
                            ),

                            16.hs,

                            // ==========================
                            // DESCRIPTION
                            // ==========================
                            Text(
                              context.l10n.authNewPasswordDescription,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.grey,
                              ),
                            ),

                            32.hs,

                            // ==========================
                            // NEW PASSWORD
                            // ==========================
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: _obscureNew,
                              enabled: !isLoading,
                              decoration: InputDecoration(
                                labelText: context.l10n.authNewPasswordLabel,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureNew
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          setState(() {
                                            _obscureNew = !_obscureNew;
                                          });
                                        },
                                ),
                                border: OutlineInputBorder(borderRadius: 12.br),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: 12.br,
                                  borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.l10n.authPasswordRequired;
                                }

                                if (value.length < 6) {
                                  return context.l10n.authPasswordMinLength;
                                }

                                return null;
                              },
                            ),

                            16.hs,

                            // ==========================
                            // CONFIRM PASSWORD
                            // ==========================
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirm,
                              enabled: !isLoading,
                              decoration: InputDecoration(
                                labelText:
                                    context.l10n.authConfirmPasswordLabel,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirm
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          setState(() {
                                            _obscureConfirm = !_obscureConfirm;
                                          });
                                        },
                                ),
                                border: OutlineInputBorder(borderRadius: 12.br),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: 12.br,
                                  borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context
                                      .l10n
                                      .authConfirmPasswordRequired;
                                }

                                if (value != _newPasswordController.text) {
                                  return context.l10n.authPasswordsDoNotMatch;
                                }

                                return null;
                              },
                            ),

                            32.hs,

                            // ==========================
                            // UPDATE PASSWORD
                            // ==========================
                            CustomElevatedButton(
                              text: context.l10n.authUpdatePasswordButton,
                              isLoading: isLoading,
                              onPressed: _submit,
                            ),

                            16.hs,

                            // ==========================
                            // BACK
                            // ==========================
                            CustomTextButton(
                              text: context.l10n.authBackButton,
                              onPressed: () {
                                if (isLoading) {
                                  return;
                                }

                                context.pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
