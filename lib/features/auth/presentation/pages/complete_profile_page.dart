import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_snackbar.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import '../widgets/activity_level_field.dart';
import '../widgets/birthday_field.dart';
import '../widgets/gender_field.dart';
import '../widgets/goal_field.dart';
import '../widgets/phone_number_field.dart';
import '../widgets/weight_height_field.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _phoneNumberController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _heightController = TextEditingController();

  DateTime? _selectedBirthday;
  String? _selectedGender;
  String? _selectedActivityLevel;
  String? _selectedGoal;

  String? _birthdayError;
  String? _genderError;
  String? _activityLevelError;
  String? _goalError;

  int? get _calculatedAge {
    if (_selectedBirthday == null) {
      return null;
    }

    final today = DateTime.now();

    int age = today.year - _selectedBirthday!.year;

    if (today.month < _selectedBirthday!.month ||
        (today.month == _selectedBirthday!.month &&
            today.day < _selectedBirthday!.day)) {
      age--;
    }

    return age;
  }

  @override
  void initState() {
    super.initState();

    _weightController.text = '70';
    _targetWeightController.text = '65';
    _heightController.text = '170';
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;

    setState(() {
      _birthdayError = _selectedBirthday == null
          ? 'Doğum tarixini seçin'
          : null;

      _genderError = _selectedGender == null ? 'Cins seçin' : null;

      _activityLevelError = _selectedActivityLevel == null
          ? 'Aktivlik səviyyəsi seçin'
          : null;

      _goalError = _selectedGoal == null ? 'Məqsəd seçin' : null;
    });

    if (!formValid ||
        _selectedBirthday == null ||
        _selectedGender == null ||
        _selectedActivityLevel == null ||
        _selectedGoal == null) {
      return;
    }

    final phoneNumber = _phoneNumberController.text.trim().replaceAll(' ', '');

    final currentWeight = double.tryParse(_weightController.text.trim());

    final targetWeight = double.tryParse(_targetWeightController.text.trim());

    final height = double.tryParse(_heightController.text.trim());

    if (currentWeight == null || height == null) {
      CustomSnackBar.show(
        context,
        message: 'Çəki və boy məlumatlarını düzgün daxil edin',
        type: SnackBarType.error,
      );

      return;
    }

    context.read<AuthBloc>().add(
      CompleteProfileSubmitted(
        phoneNumber: '+994$phoneNumber',
        birthday: _selectedBirthday!,
        gender: _selectedGender!,
        height: height,
        currentWeight: currentWeight,
        targetWeight: targetWeight,
        activityLevel: _selectedActivityLevel!,
        goal: _selectedGoal!,
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    _heightController.dispose();

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
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: 20.px + 24.py,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),

                      32.hs,

                      PhoneNumberField(
                        controller: _phoneNumberController,
                        required: true,
                      ),

                      20.hs,

                      BirthdayField(
                        selectedBirthday: _selectedBirthday,
                        calculatedAge: _calculatedAge,
                        errorText: _birthdayError,
                        onChanged: (date) {
                          setState(() {
                            _selectedBirthday = date;
                            _birthdayError = null;
                          });
                        },
                      ),

                      20.hs,

                      GenderField(
                        value: _selectedGender,
                        errorText: _genderError,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                            _genderError = null;
                          });
                        },
                      ),

                      24.hs,

                      Text(
                        'Fiziki məlumatlar',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.headline,
                        ),
                      ),

                      12.hs,

                      WeightHeightField(
                        weightController: _weightController,
                        heightController: _heightController,
                      ),

                      16.hs,

                      _buildTargetWeightField(),

                      28.hs,

                      Text(
                        'Aktivlik səviyyəniz',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.headline,
                        ),
                      ),

                      8.hs,

                      Text(
                        'Gündəlik fiziki aktivliyinizə ən uyğun variantı seçin.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.bodyText,
                        ),
                      ),

                      16.hs,

                      ActivityLevelField(
                        value: _selectedActivityLevel,
                        errorText: _activityLevelError,
                        onChanged: (value) {
                          setState(() {
                            _selectedActivityLevel = value;
                            _activityLevelError = null;
                          });
                        },
                      ),

                      28.hs,

                      Text(
                        'Məqsədiniz',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.headline,
                        ),
                      ),

                      8.hs,

                      Text(
                        'SağlamQal sizin üçün planı bu məlumata əsasən hazırlayacaq.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.bodyText,
                        ),
                      ),

                      16.hs,

                      GoalField(
                        value: _selectedGoal,
                        errorText: _goalError,
                        onChanged: (value) {
                          setState(() {
                            _selectedGoal = value;
                            _goalError = null;
                          });
                        },
                      ),

                      32.hs,

                      _buildSubmitButton(isLoading),

                      24.hs,
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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.12),
            borderRadius: 14.br,
          ),
          child: Icon(
            Icons.person_outline_rounded,
            color: AppColors.secondary,
            size: 26,
          ),
        ),

        20.hs,

        Text(
          'Profilinizi tamamlayın',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.headline,
          ),
        ),

        8.hs,

        Text(
          'Sizə uyğun kalori və qidalanma planı hazırlamaq üçün bir neçə məlumat lazımdır.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.bodyText,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTargetWeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hədəf çəki',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.headline,
            fontWeight: FontWeight.w500,
          ),
        ),

        8.hs,

        TextFormField(
          controller: _targetWeightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: 'Məsələn: 75',
            suffixText: 'kq',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: 16.br,
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: 16.br,
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: 16.br,
              borderSide: const BorderSide(
                color: AppColors.secondary,
                width: 1.5,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return null;
            }

            final weight = double.tryParse(value.trim());

            if (weight == null) {
              return 'Düzgün çəki daxil edin';
            }

            if (weight < 20 || weight > 500) {
              return 'Çəki 20-500 kq aralığında olmalıdır';
            }

            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.secondary.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: 16.br),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Davam et',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
