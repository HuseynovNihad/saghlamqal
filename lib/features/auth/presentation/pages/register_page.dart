import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../../shared/widgets/custom_text_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

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
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  String? _selectedActivityLevel;

  final List<Map<String, String>> _genders = [
    {'value': 'male', 'label': 'Kişi'},
    {'value': 'female', 'label': 'Qadın'},
  ];

  final List<Map<String, String>> _activityLevels = [
    {'value': 'sedentary', 'label': 'Oturaq'},
    {'value': 'lightly_active', 'label': 'Az aktiv'},
    {'value': 'moderately_active', 'label': 'Orta aktiv'},
    {'value': 'very_active', 'label': 'Çox aktiv'},
    {'value': 'extra_active', 'label': 'Həddindən çox aktiv'},
  ];

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      RegisterSubmitted(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        weight: double.parse(_weightController.text.trim()),
        height: double.parse(_heightController.text.trim()),
        gender: _selectedGender!,
        activityLevel: _selectedActivityLevel!,
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    20.hs,
                    Container(
                      padding: 20.p,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: 16.br,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Qeydiyyat", style: AppTextStyles.h2),
                            20.hs,

                            // Email
                            CustomTextField(
                              label: "Email",
                              hintText: "Emailinizi daxil edin",
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => AppValidators.combine(
                                value,
                                [AppValidators.isNotEmpty, AppValidators.email],
                              ),
                            ),
                            16.hs,

                            // Ad & Soyad
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    label: "Ad",
                                    hintText: "Adınızı daxil edin",
                                    controller: _firstNameController,
                                    validator: (value) => AppValidators.combine(
                                      value,
                                      [AppValidators.isNotEmpty],
                                    ),
                                  ),
                                ),
                                12.hw,
                                Expanded(
                                  child: CustomTextField(
                                    label: "Soyad",
                                    hintText: "Soyadınızı daxil edin",
                                    controller: _lastNameController,
                                    validator: (value) => AppValidators.combine(
                                      value,
                                      [AppValidators.isNotEmpty],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            16.hs,

                            // Yaş
                            CustomTextField(
                              label: "Yaş",
                              hintText: "Yaşınızı daxil edin",
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              validator: (value) => AppValidators.combine(
                                value,
                                [AppValidators.isNotEmpty],
                              ),
                            ),
                            16.hs,

                            // Çəki & Boy
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    label: "Çəki (kg)",
                                    hintText: "00.0",
                                    controller: _weightController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    validator: (value) => AppValidators.combine(
                                      value,
                                      [AppValidators.isNotEmpty],
                                    ),
                                  ),
                                ),
                                12.hw,
                                Expanded(
                                  child: CustomTextField(
                                    label: "Boy (cm)",
                                    hintText: "000",
                                    controller: _heightController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    validator: (value) => AppValidators.combine(
                                      value,
                                      [AppValidators.isNotEmpty],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            16.hs,

                            // Cins
                            Text("Cins", style: AppTextStyles.bodyMedium),
                            8.hs,
                            DropdownButtonFormField<String>(
                              value: _selectedGender,
                              decoration: InputDecoration(
                                hintText: "Cinsinizi seçin",
                                border: OutlineInputBorder(borderRadius: 12.br),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              items: _genders.map((g) {
                                return DropdownMenuItem(
                                  value: g['value'],
                                  child: Text(g['label']!),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedGender = val),
                              validator: (val) =>
                                  val == null ? 'Cins seçin' : null,
                            ),
                            16.hs,

                            // Aktivlik səviyyəsi
                            Text(
                              "Aktivlik səviyyəsi",
                              style: AppTextStyles.bodyMedium,
                            ),
                            8.hs,
                            DropdownButtonFormField<String>(
                              value: _selectedActivityLevel,
                              decoration: InputDecoration(
                                hintText: "Aktivlik səviyyənizi seçin",
                                border: OutlineInputBorder(borderRadius: 12.br),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              items: _activityLevels.map((level) {
                                return DropdownMenuItem(
                                  value: level['value'],
                                  child: Text(level['label']!),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedActivityLevel = val),
                              validator: (val) => val == null
                                  ? 'Aktivlik səviyyəsi seçin'
                                  : null,
                            ),
                            16.hs,

                            // Şifrə
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
                            16.hs,

                            // Şifrə təkrar
                            CustomTextField(
                              label: "Şifrəni təsdiqlə",
                              hintText: "Şifrənizi təkrar daxil edin",
                              controller: _confirmPasswordController,
                              isPassword: true,
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Şifrələr uyğun deyil';
                                }
                                return AppValidators.combine(value, [
                                  AppValidators.isNotEmpty,
                                ]);
                              },
                            ),
                            20.hs,

                            // Qeydiyyat düyməsi
                            CustomElevatedButton(
                              text: "Qeydiyyatdan keç",
                              isLoading: state is AuthLoading,
                              onPressed: _register,
                            ),
                            12.hs,

                            // Login-ə keç
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Hesabın var? ",
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomTextButton(
                                    text: "Daxil ol",
                                    onPressed: () => context.pop(),
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            "Sağlam həyat sənin əlindədir 💚",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
