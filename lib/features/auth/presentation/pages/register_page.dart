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
import '../widgets/activity_level_field.dart';
import '../widgets/birthday_field.dart';
import '../widgets/gender_field.dart';
import '../widgets/name_field.dart';
import '../widgets/weight_height_field.dart';

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
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  String? _selectedActivityLevel;
  DateTime? _selectedBirthday;

  String? _genderError;
  String? _activityLevelError;
  String? _birthdayError;

  int? get _calculatedAge {
    if (_selectedBirthday == null) return null;
    final today = DateTime.now();
    int age = today.year - _selectedBirthday!.year;
    if (today.month < _selectedBirthday!.month ||
        (today.month == _selectedBirthday!.month &&
            today.day < _selectedBirthday!.day)) {
      age--;
    }
    return age;
  }

  void _register() {
    setState(() {
      _genderError = _selectedGender == null ? 'Cins seçin' : null;
      _activityLevelError = _selectedActivityLevel == null
          ? 'Aktivlik səviyyəsi seçin'
          : null;
      _birthdayError = _selectedBirthday == null
          ? 'Doğum tarixini seçin'
          : null;
    });

    if (!_formKey.currentState!.validate()) return;
    if (_selectedGender == null ||
        _selectedActivityLevel == null ||
        _selectedBirthday == null) {
      return;
    }

    context.read<AuthBloc>().add(
      RegisterSubmitted(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        age: _calculatedAge!,
        birthday: _selectedBirthday!,
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
                    Container(
                      padding: 20.p,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: 16.br,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Qeydiyyat", style: AppTextStyles.h2),
                            20.hs,
                            const _SectionHeader(
                              icon: '👤',
                              title: 'Şəxsi məlumat',
                            ),
                            12.hs,
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
                            NameField(
                              firstNameController: _firstNameController,
                              lastNameController: _lastNameController,
                            ),
                            16.hs,
                            BirthdayField(
                              selectedBirthday: _selectedBirthday,
                              calculatedAge: _calculatedAge,
                              errorText: _birthdayError,
                              onChanged: (date) => setState(() {
                                _selectedBirthday = date;
                                _birthdayError = null;
                              }),
                            ),
                            24.hs,
                            const _SectionHeader(
                              icon: '📏',
                              title: 'Fiziki məlumat',
                            ),
                            12.hs,
                            WeightHeightField(
                              weightController: _weightController,
                              heightController: _heightController,
                            ),
                            16.hs,
                            GenderField(
                              value: _selectedGender,
                              errorText: _genderError,
                              onChanged: (val) => setState(() {
                                _selectedGender = val;
                                _genderError = null;
                              }),
                            ),
                            24.hs,
                            const _SectionHeader(
                              icon: '🏃',
                              title: 'Aktivlik səviyyəsi',
                            ),
                            12.hs,
                            ActivityLevelField(
                              value: _selectedActivityLevel,
                              errorText: _activityLevelError,
                              onChanged: (val) => setState(() {
                                _selectedActivityLevel = val;
                                _activityLevelError = null;
                              }),
                            ),
                            24.hs,
                            const _SectionHeader(
                              icon: '🔒',
                              title: 'Təhlükəsizlik',
                            ),
                            12.hs,
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
                            CustomElevatedButton(
                              text: "Qeydiyyatdan keç",
                              isLoading: state is AuthLoading,
                              onPressed: _register,
                            ),
                            12.hs,
                            Row(
                              children: [
                                const Expanded(child: Divider(thickness: 1)),
                                Padding(padding: 8.px, child: Text("və ya")),
                                const Expanded(child: Divider(thickness: 1)),
                              ],
                            ),
                            12.hs,
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
                            12.hs,
                            Text(
                              "Sağlam həyat sənin əlindədir 💚",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.grey,
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

class _SectionHeader extends StatelessWidget {
  final String icon;
  final String title;

  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Text(icon, style: const TextStyle(fontSize: 16)),
        6.hw,
        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        6.hw,
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
