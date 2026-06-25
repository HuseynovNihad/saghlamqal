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
