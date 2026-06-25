// profile_bloc.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/about_us_entity.dart';
import '../../domain/entities/terms_entity.dart';
import '../../domain/usecases/get_about_us_usecase.dart';
import '../../domain/usecases/get_privacy_policy_usecase.dart';
import '../../domain/usecases/get_terms_of_service_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetTermsOfServiceUseCase _getTermsOfService;
  final GetPrivacyPolicyUseCase _getPrivacyPolicy;
  final GetAboutUsUseCase _getAboutUs;

  ProfileBloc({
    required GetTermsOfServiceUseCase getTermsOfService,
    required GetPrivacyPolicyUseCase getPrivacyPolicy,
    required GetAboutUsUseCase getAboutUs,
  }) : _getTermsOfService = getTermsOfService,
       _getPrivacyPolicy = getPrivacyPolicy,
       _getAboutUs = getAboutUs,
       super(const ProfileInitial()) {
    on<ProfileTermsOfServiceRequested>(_onTermsOfServiceRequested);
    on<ProfilePrivacyPolicyRequested>(_onPrivacyPolicyRequested);
    on<ProfileAboutUsRequested>(_onAboutUsRequested);
  }

  Future<void> _onTermsOfServiceRequested(
    ProfileTermsOfServiceRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final terms = await _getTermsOfService();
      emit(ProfileTermsLoaded(terms: terms));
    } catch (e) {
      log('TermsOfService error: $e');
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onPrivacyPolicyRequested(
    ProfilePrivacyPolicyRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final policy = await _getPrivacyPolicy();
      emit(ProfileTermsLoaded(terms: policy));
    } catch (e) {
      log('PrivacyPolicy error: $e');
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onAboutUsRequested(
    ProfileAboutUsRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final aboutUs = await _getAboutUs();
      emit(ProfileAboutUsLoaded(aboutUs: aboutUs));
    } catch (e) {
      log('AboutUs error: $e');
      emit(ProfileError(message: e.toString()));
    }
  }
}
