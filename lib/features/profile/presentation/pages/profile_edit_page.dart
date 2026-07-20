import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalori_tracker/core/utils/sized_box_extension.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../profile/domain/entities/patient_profile_entity.dart';
import '../../../profile/domain/usecases/update_patient_profile_usecase.dart';
import '../../../profile/domain/usecases/update_profile_usecase.dart';
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
      create: (_) => sl<ProfileBloc>()
        ..add(const ProfileRequested())
        ..add(const PatientProfileRequested()),
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

  String _initialFirstName = '';
  String _initialLastName = '';
  String _initialPhoneDigits = '';

  DateTime? _initialBirthday;
  int? _initialHeight;
  double? _initialWeight;
  double? _initialTargetWeight;
  String? _initialGender;
  String? _initialActivityLevel;
  String? _initialGoal;

  bool _hasUserHydrated = false;
  bool _hasPatientProfileHydrated = false;
  bool get _hasHydrated => _hasUserHydrated && _hasPatientProfileHydrated;

  bool _isSaving = false;

  String _avatarInitial = 'U';

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

    _initialFirstName = _firstNameController.text;
    _initialLastName = _lastNameController.text;
    _initialPhoneDigits = _phoneController.text;

    _avatarInitial = _initialFor(user);

    _hasUserHydrated = true;
  }

  void _hydrateFromPatientProfile(PatientProfileEntity profile) {
    _birthday = profile.birthday;
    _height = profile.height;
    _weight = profile.currentWeight;
    _targetWeight = profile.targetWeight;
    _gender = profile.gender;
    _activityLevel = profile.activityLevel;
    _goal = profile.goal;

    _initialBirthday = profile.birthday;
    _initialHeight = profile.height;
    _initialWeight = profile.currentWeight;
    _initialTargetWeight = profile.targetWeight;
    _initialGender = profile.gender;
    _initialActivityLevel = profile.activityLevel;
    _initialGoal = profile.goal;

    _hasPatientProfileHydrated = true;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool get _isPersonalInfoChanged {
    return _firstNameController.text.trim() != _initialFirstName ||
        _lastNameController.text.trim() != _initialLastName ||
        _phoneController.text.trim() != _initialPhoneDigits;
  }

  bool get _isPhysicalInfoChanged {
    return _birthday != _initialBirthday ||
        _height != _initialHeight ||
        _weight != _initialWeight ||
        _targetWeight != _initialTargetWeight ||
        _gender != _initialGender ||
        _activityLevel != _initialActivityLevel ||
        _goal != _initialGoal;
  }

  void _save() {
    final bloc = context.read<ProfileBloc>();
    final personalChanged = _isPersonalInfoChanged;
    final physicalChanged = _isPhysicalInfoChanged;

    if (!personalChanged && !physicalChanged) {
      CustomSnackBar.show(
        context,
        message: 'Heç bir dəyişiklik yoxdur',
        type: SnackBarType.info,
      );
      return;
    }

    setState(() => _isSaving = true);

    if (personalChanged) {
      bloc.add(
        ProfileUpdateRequested(
          params: UpdateProfileParams(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            phoneNumber: '$_phoneCountryCode${_phoneController.text.trim()}',
          ),
        ),
      );
    }

    if (physicalChanged) {
      bloc.add(
        PatientProfileUpdateRequested(
          params: UpdatePatientProfileParams(
            birthday: _birthday,
            gender: _gender,
            height: _height,
            currentWeight: _weight,
            targetWeight: _targetWeight,
            activityLevel: _activityLevel,
            goal: _goal,
          ),
        ),
      );
    }
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
            if (state is ProfileLoaded && !_hasUserHydrated) {
              setState(() => _hydrateFromUser(state.user));
            }
            if (state is PatientProfileLoaded && !_hasPatientProfileHydrated) {
              setState(() => _hydrateFromPatientProfile(state.patientProfile));
            }

            if (state is ProfileError || state is PatientProfileError) {
              final message = state is ProfileError
                  ? state.message
                  : (state as PatientProfileError).message;
              CustomSnackBar.show(
                context,
                message: message,
                type: SnackBarType.error,
              );
            }

            if (state is ProfileUpdateSuccess) {
              setState(() {
                _hydrateFromUser(state.user);
                _isSaving = false;
              });
              context.read<AuthBloc>().add(AuthUserUpdated(state.user));
              _maybeShowSavedSnackBar(context);
            }
            if (state is PatientProfileUpdateSuccess) {
              setState(() {
                _hydrateFromPatientProfile(state.patientProfile);
                _isSaving = false;
              });
              context.read<HomeBloc>().add(const HomeDailyGoalRequested());
              _maybeShowSavedSnackBar(context);
            }

            if (state is ProfileUpdateError) {
              setState(() => _isSaving = false);
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );
            }
            if (state is PatientProfileUpdateError) {
              setState(() => _isSaving = false);
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (!_hasHydrated) {
              if (state is ProfileError || state is PatientProfileError) {
                final message = state is ProfileError
                    ? state.message
                    : (state as PatientProfileError).message;
                return Center(
                  child: Padding(
                    padding: 24.p,
                    child: Text(
                      message,
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

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                ProfileAvatar(
                  initial: _avatarInitial,
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
                  onHeightChanged: (value) => setState(() {
                    _height = value.clamp(_minHeight, _maxHeight);
                  }),
                  onWeightChanged: (value) => setState(() {
                    _weight = value.clamp(_minWeight, _maxWeight);
                  }),
                  onTargetWeightChanged: (value) => setState(() {
                    _targetWeight = value.clamp(
                      _minTargetWeight,
                      _maxTargetWeight,
                    );
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
              child: SaveChangesButton(
                isLoading: _isSaving,
                onPressed: _isSaving ? null : _save,
              ),
            )
          : null,
    );
  }

  void _maybeShowSavedSnackBar(BuildContext context) {
    final personalChanged = _isPersonalInfoChanged;
    final physicalChanged = _isPhysicalInfoChanged;
    if (!personalChanged && !physicalChanged) {
      CustomSnackBar.show(
        context,
        message: 'Profil yadda saxlanıldı',
        type: SnackBarType.success,
        position: SnackBarPosition.top,
      );
    }
  }
}
