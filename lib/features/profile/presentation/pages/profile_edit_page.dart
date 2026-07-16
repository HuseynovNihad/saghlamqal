import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalori_tracker/core/utils/sized_box_extension.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../widgets/profile_edit/body_metrics_card.dart';
import '../widgets/profile_edit/personal_info_card.dart';
import '../widgets/profile_edit/preferences_card.dart';
import '../widgets/profile_edit/profile_avatar.dart';
import '../widgets/profile_edit/save_changes_button.dart';

import '../../../../core/di/injection_container.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(const ProfileRequested()),
      child: const _ProfileEditView(),
    );
  }
}

class _ProfileEditView extends StatefulWidget {
  const _ProfileEditView();

  @override
  State<_ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<_ProfileEditView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Realistik limitlər
  static const int _minHeight = 50;
  static const int _maxHeight = 250;
  static const double _minWeight = 20;
  static const double _maxWeight = 300;
  static const double _minTargetWeight = 20;
  static const double _maxTargetWeight = 300;

  static const String _phoneCountryCode = '+994';

  DateTime? _birthday;
  int? _height;
  double? _weight;
  double? _targetWeight;

  String? _gender;
  String? _activityLevel;
  String? _goal;

  bool _hasHydrated = false;

  /// PhoneNumberField yalnız yerli 9 rəqəmi (994 kod xaric) qəbul edir,
  /// ona görə controller-ə ölkə kodunu təmizləyib boşluqsuz yazırıq.
  String _stripCountryCode(String? rawPhone) {
    if (rawPhone == null || rawPhone.isEmpty) return '';
    var digits = rawPhone.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('994')) {
      digits = digits.substring(3);
    }
    return digits;
  }

  void _hydrateFromUser(UserEntity user) {
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _emailController.text = user.email;
    _phoneController.text = _stripCountryCode(user.phoneNumber);
    _birthday = user.birthday;
    _height = user.height?.toInt();
    _weight = user.weight;
    _targetWeight = user.targetWeight;
    _gender = user.gender;
    _activityLevel = user.activityLevel;
    _goal = user.goal;
    _hasHydrated = true;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() {
    _phoneController.text.replaceAll(RegExp(r'\D'), '');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  String _initialFor(UserEntity user) {
    if (user.firstName != null && user.firstName!.isNotEmpty) {
      return user.firstName![0];
    }
    if (user.email.isNotEmpty) {
      return user.email[0];
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text('Profil redaktəsi', style: AppTextStyles.h3),
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded && !_hasHydrated) {
              setState(() => _hydrateFromUser(state.user));
            }
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (!_hasHydrated) {
              if (state is ProfileError) {
                return Center(
                  child: Padding(
                    padding: 24.p,
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.bodyText),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            final user = state is ProfileLoaded ? state.user : null;

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                ProfileAvatar(
                  initial: user != null ? _initialFor(user) : 'U',
                  imageUrl: null,
                  onEditTap: () {
                    // TODO: image picker
                  },
                ),
                16.hs,
                PersonalInfoCard(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  birthday: _birthday,
                  onBirthdayChanged: (value) =>
                      setState(() => _birthday = value),
                ),
                20.hs,
                BodyMetricsCard(
                  height: _height,
                  weight: _weight,
                  targetWeight: _targetWeight,
                  onHeightDecrement: () => setState(() {
                    final current = _height ?? _minHeight;
                    _height = current > _minHeight ? current - 1 : _minHeight;
                  }),
                  onHeightIncrement: () => setState(() {
                    final current = _height ?? (_minHeight - 1);
                    _height = current < _maxHeight ? current + 1 : _maxHeight;
                  }),
                  onWeightDecrement: () => setState(() {
                    final current = _weight ?? _minWeight;
                    _weight = current > _minWeight ? current - 1 : _minWeight;
                  }),
                  onWeightIncrement: () => setState(() {
                    final current = _weight ?? (_minWeight - 1);
                    _weight = current < _maxWeight ? current + 1 : _maxWeight;
                  }),
                  onTargetWeightDecrement: () => setState(() {
                    final current = _targetWeight ?? _minTargetWeight;
                    _targetWeight = current > _minTargetWeight
                        ? current - 1
                        : _minTargetWeight;
                  }),
                  onTargetWeightIncrement: () => setState(() {
                    final current = _targetWeight ?? (_minTargetWeight - 1);
                    _targetWeight = current < _maxTargetWeight
                        ? current + 1
                        : _maxTargetWeight;
                  }),
                ),
                20.hs,
                PreferencesCard(
                  gender: _gender,
                  onGenderChanged: (value) => setState(() => _gender = value),
                  activityLevel: _activityLevel,
                  onActivityLevelChanged: (value) =>
                      setState(() => _activityLevel = value),
                  goal: _goal,
                  onGoalChanged: (value) => setState(() => _goal = value),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: _hasHydrated
          ? SafeArea(
              minimum: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: SaveChangesButton(onPressed: _save),
            )
          : null,
    );
  }
}
