part of 'profile_bloc.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileTermsLoaded extends ProfileState {
  final TermsEntity terms;

  const ProfileTermsLoaded({required this.terms});
}

final class ProfileAboutUsLoaded extends ProfileState {
  final AboutUsEntity aboutUs;

  const ProfileAboutUsLoaded({required this.aboutUs});
}

final class ProfileLoaded extends ProfileState {
  final UserEntity user;

  const ProfileLoaded({required this.user});
}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});
}

final class ProfileUpdating extends ProfileState {
  const ProfileUpdating();
}

final class ProfileUpdateSuccess extends ProfileState {
  final UserEntity user;

  const ProfileUpdateSuccess({required this.user});
}

final class ProfileUpdateError extends ProfileState {
  final String message;

  const ProfileUpdateError({required this.message});
}

final class PatientProfileLoading extends ProfileState {
  const PatientProfileLoading();
}

final class PatientProfileLoaded extends ProfileState {
  final PatientProfileEntity patientProfile;

  const PatientProfileLoaded({required this.patientProfile});
}

final class PatientProfileError extends ProfileState {
  final String message;

  const PatientProfileError({required this.message});
}

final class PatientProfileUpdating extends ProfileState {
  const PatientProfileUpdating();
}

final class PatientProfileUpdateSuccess extends ProfileState {
  final PatientProfileEntity patientProfile;

  const PatientProfileUpdateSuccess({required this.patientProfile});
}

final class PatientProfileUpdateError extends ProfileState {
  final String message;

  const PatientProfileUpdateError({required this.message});
}
