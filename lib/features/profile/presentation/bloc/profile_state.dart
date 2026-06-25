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

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});
}
