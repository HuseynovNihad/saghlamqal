import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/otp_verify_mode.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/register_steps/register_activity_level_step.dart';
import '../widgets/register_steps/register_goal_step.dart';
import '../widgets/register_steps/register_personal_info_step.dart';
import '../widgets/register_steps/register_physical_info_step.dart';
import '../widgets/register_steps/register_security_step.dart';
import '../widgets/step_indicator.dart';
import 'otp_verify_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const int _totalSteps = 5;

  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();
  final _step5FormKey = GlobalKey<FormState>();

  int _currentStep = 0;

  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _heightController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  String? _selectedActivityLevel;
  String? _selectedGoal;
  DateTime? _selectedBirthday;

  String? _genderError;
  String? _activityLevelError;
  String? _goalError;
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

  bool _validateStep(int step) {
    switch (step) {
      case 0:
        setState(() {
          _birthdayError = _selectedBirthday == null
              ? 'Doğum tarixini seçin'
              : null;
        });
        final formOk = _step1FormKey.currentState?.validate() ?? false;
        return formOk && _selectedBirthday != null;
      case 1:
        setState(() {
          _genderError = _selectedGender == null ? 'Cins seçin' : null;
        });
        final formOk = _step2FormKey.currentState?.validate() ?? false;
        return formOk && _selectedGender != null;
      case 2:
        setState(() {
          _activityLevelError = _selectedActivityLevel == null
              ? 'Aktivlik səviyyəsi seçin'
              : null;
        });
        return _selectedActivityLevel != null;
      case 3:
        setState(() {
          _goalError = _selectedGoal == null ? 'Məqsəd seçin' : null;
        });
        return _selectedGoal != null;
      default:
        return true;
    }
  }

  void _nextStep() {
    if (!_validateStep(_currentStep)) return;
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _register() {
    if (!(_step5FormKey.currentState?.validate() ?? false)) return;
    if (_selectedGender == null ||
        _selectedActivityLevel == null ||
        _selectedGoal == null ||
        _selectedBirthday == null) {
      return;
    }

    context.read<AuthBloc>().add(
      RegisterSubmitted(
        email: _emailController.text.trim(),
        phoneNumber:
            "+994${_phoneNumberController.text.trim().replaceAll(' ', '')}",
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        age: _calculatedAge!,
        birthday: _selectedBirthday!,
        weight: double.parse(_weightController.text.trim()),
        targetWeight: double.parse(_targetWeightController.text.trim()),
        height: double.parse(_heightController.text.trim()),
        gender: _selectedGender!,
        activityLevel: _selectedActivityLevel!,
        goal: _selectedGoal!,
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    _heightController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );
            } else if (state is AuthRegistered) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.push(
                  AppRoutes.otpVerify,
                  extra: OtpVerifyExtra(
                    email: state.email,
                    mode: OtpVerifyMode.register,
                  ),
                );
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: 8.px + 24.py,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: 20.p,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StepIndicator(
                            currentStep: _currentStep,
                            totalSteps: _totalSteps,
                          ),
                          20.hs,
                          ClipRect(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              switchInCurve: Curves.easeOut,
                              switchOutCurve: Curves.easeIn,
                              transitionBuilder: (child, animation) {
                                final offsetAnimation = Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              layoutBuilder: (currentChild, previousChildren) {
                                return Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    ...previousChildren,
                                    if (currentChild != null) currentChild,
                                  ],
                                );
                              },
                              child: KeyedSubtree(
                                key: ValueKey(_currentStep),
                                child: _buildStep(state),
                              ),
                            ),
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

  Widget _buildStep(AuthState state) {
    switch (_currentStep) {
      case 0:
        return RegisterPersonalInfoStep(
          formKey: _step1FormKey,
          emailController: _emailController,
          phoneNumberController: _phoneNumberController,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          selectedBirthday: _selectedBirthday,
          calculatedAge: _calculatedAge,
          birthdayError: _birthdayError,
          onBirthdayChanged: (date) => setState(() {
            _selectedBirthday = date;
            _birthdayError = null;
          }),
          onNext: _nextStep,
          onLoginTap: () => context.pop(),
        );
      case 1:
        return RegisterPhysicalInfoStep(
          formKey: _step2FormKey,
          weightController: _weightController,
          heightController: _heightController,
          targetWeightController: _targetWeightController,
          selectedGender: _selectedGender,
          genderError: _genderError,
          onGenderChanged: (val) => setState(() {
            _selectedGender = val;
            _genderError = null;
          }),
          onNext: _nextStep,
          onBack: _prevStep,
          onLoginTap: () => context.pop(),
        );
      case 2:
        return RegisterActivityLevelStep(
          selectedActivityLevel: _selectedActivityLevel,
          activityLevelError: _activityLevelError,
          onChanged: (val) => setState(() {
            _selectedActivityLevel = val;
            _activityLevelError = null;
          }),
          onNext: _nextStep,
          onBack: _prevStep,
          onLoginTap: () => context.pop(),
        );
      case 3:
        return RegisterGoalStep(
          selectedGoal: _selectedGoal,
          goalError: _goalError,
          onChanged: (val) => setState(() {
            _selectedGoal = val;
            _goalError = null;
          }),
          onNext: _nextStep,
          onBack: _prevStep,
          onLoginTap: () => context.pop(),
        );
      case 4:
      default:
        return RegisterSecurityStep(
          formKey: _step5FormKey,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          isLoading: state is AuthLoading,
          onRegister: _register,
          onBack: _prevStep,
          onLoginTap: () => context.pop(),
        );
    }
  }
}
