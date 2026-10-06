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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      ForgotPasswordSubmitted(email: _emailController.text.trim()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );

              return;
            }

            if (state is AuthForgotPasswordSent) {
              CustomSnackBar.show(
                context,
                message: context.l10n.authPasswordResetCodeSent,
                type: SnackBarType.success,
              );

              context.push(AppRoutes.resetOtp, extra: state.email);
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ==========================
                            // TITLE
                            // ==========================
                            Text(
                              context.l10n.authForgotPasswordTitle,
                              style: AppTextStyles.h2,
                            ),

                            16.hs,

                            // ==========================
                            // DESCRIPTION
                            // ==========================
                            Text(
                              context.l10n.authForgotPasswordDescription,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.grey,
                              ),
                            ),

                            32.hs,

                            // ==========================
                            // EMAIL
                            // ==========================
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: context.l10n.authEmailLabel,
                                hintText: context.l10n.authEmailExample,
                                prefixIcon: const Icon(Icons.email_outlined),
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
                                if (value == null || value.trim().isEmpty) {
                                  return context.l10n.authEmailRequired;
                                }

                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );

                                if (!emailRegex.hasMatch(value.trim())) {
                                  return context.l10n.authEmailInvalid;
                                }

                                return null;
                              },
                            ),

                            32.hs,

                            // ==========================
                            // SEND CODE
                            // ==========================
                            CustomElevatedButton(
                              text: context.l10n.authSendCodeButton,
                              isLoading: isLoading,
                              onPressed: isLoading ? null : _submit,
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
