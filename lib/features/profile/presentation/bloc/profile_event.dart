part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

final class ProfileTermsOfServiceRequested extends ProfileEvent {
  const ProfileTermsOfServiceRequested();
}

final class ProfilePrivacyPolicyRequested extends ProfileEvent {
  const ProfilePrivacyPolicyRequested();
}

final class ProfileAboutUsRequested extends ProfileEvent {
  const ProfileAboutUsRequested();
}

final class ProfileRequested extends ProfileEvent {
  const ProfileRequested();
}

final class ProfileUpdateRequested extends ProfileEvent {
  final UpdateProfileParams params;

  const ProfileUpdateRequested({required this.params});
}

final class PatientProfileRequested extends ProfileEvent {
  const PatientProfileRequested();
}

final class PatientProfileUpdateRequested extends ProfileEvent {
  final UpdatePatientProfileParams params;

  const PatientProfileUpdateRequested({required this.params});
}
