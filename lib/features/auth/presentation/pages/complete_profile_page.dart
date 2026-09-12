import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
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

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    _heightController.dispose();

    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();

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

    final currentWeight = double.tryParse(
      _weightController.text.trim().replaceAll(',', '.'),
    );

    final targetWeight = double.tryParse(
      _targetWeightController.text.trim().replaceAll(',', '.'),
    );

    final height = double.tryParse(
      _heightController.text.trim().replaceAll(',', '.'),
    );

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

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),

                            const SizedBox(height: 18),

                            _buildSectionCard(
                              icon: Icons.person_outline_rounded,
                              title: 'Şəxsi məlumatlar',
                              description:
                                  'Sizi daha yaxşı tanımaq üçün əsas məlumatları tamamlayın.',
                              children: [
                                PhoneNumberField(
                                  controller: _phoneNumberController,
                                  required: true,
                                ),

                                const SizedBox(height: 18),

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

                                const SizedBox(height: 18),

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
                              ],
                            ),

                            const SizedBox(height: 16),

                            _buildSectionCard(
                              icon: Icons.monitor_weight_outlined,
                              title: 'Bədən göstəriciləri',
                              description:
                                  'Boy və çəki məlumatlarınız gündəlik ehtiyacların hesablanmasına kömək edir.',
                              children: [
                                WeightHeightField(
                                  weightController: _weightController,
                                  heightController: _heightController,
                                ),

                                const SizedBox(height: 18),

                                _buildTargetWeightField(),
                              ],
                            ),

                            const SizedBox(height: 16),

                            _buildSectionCard(
                              icon: Icons.directions_run_rounded,
                              title: 'Aktivlik səviyyəsi',
                              description:
                                  'Adi gününüzə ən yaxın fiziki aktivlik səviyyəsini seçin.',
                              children: [
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
                              ],
                            ),

                            const SizedBox(height: 16),

                            _buildSectionCard(
                              icon: Icons.flag_outlined,
                              title: 'Məqsədiniz',
                              description:
                                  'SağlamQal planınızı seçdiyiniz məqsədə uyğun fərdiləşdirəcək.',
                              children: [
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
                              ],
                            ),

                            const SizedBox(height: 22),

                            _buildPrivacyNote(),

                            const SizedBox(height: 24),

                            _buildSubmitButton(isLoading),

                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.022),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.person_add_alt_1_rounded,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      'Son addım',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          Text(
            'Profilinizi tamamlayaq',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 23,
              height: 1.15,
              letterSpacing: -0.4,
              fontWeight: FontWeight.w700,
              color: AppColors.headline,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Sizə uyğun kalori və qidalanma planı hazırlamaq üçün bir neçə məlumat lazımdır.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.bodyText,
              height: 1.45,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              Expanded(child: _buildProgressLine(active: true)),
              const SizedBox(width: 5),
              Expanded(child: _buildProgressLine(active: true)),
              const SizedBox(width: 5),
              Expanded(child: _buildProgressLine(active: true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine({required bool active}) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        color: active ? AppColors.secondary : AppColors.borderColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String description,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.65)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.022),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: AppColors.secondary, size: 20),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.headline,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.bodyText,
                        height: 1.45,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(height: 1, color: AppColors.borderColor.withOpacity(0.55)),

          const SizedBox(height: 20),

          ...children,
        ],
      ),
    );
  }

  Widget _buildTargetWeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Hədəf çəki',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.headline,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),

            const SizedBox(width: 6),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                'İstəyə bağlı',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.secondary,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: _targetWeightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Məsələn: 65',
            suffixText: 'kq',
            filled: true,
            fillColor: AppColors.textfieldColor,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            suffixStyle: const TextStyle(
              color: AppColors.bodyText,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: TextStyle(
              color: AppColors.bodyText.withOpacity(0.55),
              fontSize: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.secondary,
                width: 1.4,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.error, width: 1.4),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return null;
            }

            final weight = double.tryParse(value.trim().replaceAll(',', '.'));

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

  Widget _buildPrivacyNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withOpacity(0.11)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.09),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_outline_rounded,
              size: 17,
              color: AppColors.secondary,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Text(
              'Məlumatlarınız yalnız sizə uyğun fərdi plan yaratmaq üçün istifadə olunur.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.bodyText,
                height: 1.45,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : _submit,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.secondary.withOpacity(0.45),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.3,
                    color: Colors.white,
                  ),
                )
              : const Row(
                  key: ValueKey('button'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profili tamamla',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 19),
                  ],
                ),
        ),
      ),
    );
  }
}
