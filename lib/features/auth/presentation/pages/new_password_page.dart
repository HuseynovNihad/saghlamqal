import 'dart:developer';

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

/// OtpVerifyPage-dən bu səhifəyə ötürülən məlumat
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
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      ResetPasswordSubmitted(
        email: widget.email,
        otp: widget.otp,
        newPassword: _newPasswordController.text,
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
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            log('📍 NewPasswordPage listener | state=${state.runtimeType}');
            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );
            } else if (state is AuthPasswordResetSuccess) {
              log(
                '📍 AuthPasswordResetSuccess alındı, login-ə keçid planlaşdırılır',
              );
              CustomSnackBar.show(
                context,
                message: 'Şifrəniz uğurla yeniləndi',
                type: SnackBarType.success,
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.read<AuthBloc>().add(const AuthStateReset());
                  context.go(AppRoutes.login);
                }
              });
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
                            Text("Yeni Şifrə", style: AppTextStyles.h2),
                            16.hs,
                            Text(
                              "Yeni şifrənizi daxil edin",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            32.hs,

                            // Yeni şifrə
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: _obscureNew,
                              decoration: InputDecoration(
                                labelText: 'Yeni şifrə',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureNew
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscureNew = !_obscureNew,
                                  ),
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
                                  return 'Şifrə daxil edin';
                                }
                                if (value.length < 6) {
                                  return 'Şifrə ən az 6 simvol olmalıdır';
                                }
                                return null;
                              },
                            ),
                            16.hs,

                            // Şifrəni təsdiqlə
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirm,
                              decoration: InputDecoration(
                                labelText: 'Şifrəni təsdiqlə',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirm
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscureConfirm = !_obscureConfirm,
                                  ),
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
                                  return 'Şifrəni təsdiqləyin';
                                }
                                if (value != _newPasswordController.text) {
                                  return 'Şifrələr uyğun gəlmir';
                                }
                                return null;
                              },
                            ),
                            32.hs,

                            CustomElevatedButton(
                              text: "Şifrəni Yenilə",
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
