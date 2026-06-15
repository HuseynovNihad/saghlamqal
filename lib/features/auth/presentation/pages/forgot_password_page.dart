import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_text_styles.dart';
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
    if (!_formKey.currentState!.validate()) return;
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
            } else if (state is AuthForgotPasswordSent) {
              CustomSnackBar.show(
                context,
                message: 'Şifrə sıfırlama kodu göndərildi',
                type: SnackBarType.success,
              );
              context.push(AppRoutes.resetOtp, extra: state.email);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: 16.p,
                child: Form(
                  key: _formKey,
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
                            Text("Şifrəni Unutdum", style: AppTextStyles.h2),
                            16.hs,
                            Text(
                              "Email ünvanınızı daxil edin, şifrə sıfırlama kodu göndərəcəyik",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            32.hs,
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'example@email.com',
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
                                  return 'Email daxil edin';
                                }
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return 'Düzgün email daxil edin';
                                }
                                return null;
                              },
                            ),
                            32.hs,
                            CustomElevatedButton(
                              text: "Kodu Göndər",
                              isLoading: state is AuthLoading,
                              onPressed: _submit,
                            ),
                            16.hs,
                            CustomTextButton(
                              text: "Geri qayıt",
                              onPressed: () => context.pop(),
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
