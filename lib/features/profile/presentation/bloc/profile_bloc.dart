// profile_bloc.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/about_us_entity.dart';
import '../../domain/entities/patient_profile_entity.dart';
import '../../domain/entities/terms_entity.dart';
import '../../domain/usecases/get_about_us_usecase.dart';
import '../../domain/usecases/get_patient_profile_usecase.dart';
import '../../domain/usecases/get_privacy_policy_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/get_terms_of_service_usecase.dart';
import '../../domain/usecases/update_patient_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetTermsOfServiceUseCase _getTermsOfService;
  final GetPrivacyPolicyUseCase _getPrivacyPolicy;
  final GetAboutUsUseCase _getAboutUs;
  final GetProfileUseCase _getProfile;
  final UpdateProfileUseCase _updateProfile;
  final GetPatientProfileUseCase _getPatientProfile;
  final UpdatePatientProfileUseCase _updatePatientProfile;

  ProfileBloc({
    required GetTermsOfServiceUseCase getTermsOfService,
    required GetPrivacyPolicyUseCase getPrivacyPolicy,
    required GetAboutUsUseCase getAboutUs,
    required GetProfileUseCase getProfile,
    required UpdateProfileUseCase updateProfile,
    required GetPatientProfileUseCase getPatientProfile,
    required UpdatePatientProfileUseCase updatePatientProfile,
  }) : _getTermsOfService = getTermsOfService,
       _getPrivacyPolicy = getPrivacyPolicy,
       _getAboutUs = getAboutUs,
       _getProfile = getProfile,
       _updateProfile = updateProfile,
       _getPatientProfile = getPatientProfile,
       _updatePatientProfile = updatePatientProfile,
       super(const ProfileInitial()) {
    on<ProfileTermsOfServiceRequested>(_onTermsOfServiceRequested);
    on<ProfilePrivacyPolicyRequested>(_onPrivacyPolicyRequested);
    on<ProfileAboutUsRequested>(_onAboutUsRequested);
    on<ProfileRequested>(_onProfileRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<PatientProfileRequested>(_onPatientProfileRequested);
    on<PatientProfileUpdateRequested>(_onPatientProfileUpdateRequested);
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

  Future<void> _onProfileRequested(
    ProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final user = await _getProfile();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      log('Profile error: $e');
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onProfileUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileUpdating());
    try {
      final user = await _updateProfile(event.params);
      emit(ProfileUpdateSuccess(user: user));
    } catch (e) {
      log('ProfileUpdate error: $e');
      emit(ProfileUpdateError(message: e.toString()));
    }
  }

  Future<void> _onPatientProfileRequested(
    PatientProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const PatientProfileLoading());
    try {
      final patientProfile = await _getPatientProfile();
      emit(PatientProfileLoaded(patientProfile: patientProfile));
    } catch (e) {
      log('PatientProfile error: $e');
      emit(PatientProfileError(message: e.toString()));
    }
  }

  Future<void> _onPatientProfileUpdateRequested(
    PatientProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const PatientProfileUpdating());
    try {
      final patientProfile = await _updatePatientProfile(event.params);
      emit(PatientProfileUpdateSuccess(patientProfile: patientProfile));
    } catch (e) {
      log('PatientProfileUpdate error: $e');
      emit(PatientProfileUpdateError(message: e.toString()));
    }
  }
}
