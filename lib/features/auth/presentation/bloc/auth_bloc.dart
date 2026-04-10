import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/storage/token_storage.dart';
import '../../data/models/request/register_request.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginSubmitted>(_onLogin);
    on<RegisterSubmitted>(_onRegister);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    await Future.delayed(const Duration(seconds: 3));

    final token = sl<TokenStorage>().getToken();

    if (token == null || token.isEmpty) {
      emit(const AuthUnauthenticated());
      return;
    }

    try {
      final response = await _authRepository.loginWithToken(token);
      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final response = await _authRepository.login(event.email, event.password);
      sl<TokenStorage>().saveToken(response.token);
      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final response = await _authRepository.register(
        RegisterRequest(
          email: event.email,
          firstName: event.firstName,
          lastName: event.lastName,
          age: event.age,
          weight: event.weight,
          height: event.height,
          gender: event.gender,
          activityLevel: event.activityLevel,
          password: event.password,
          confirmPassword: event.confirmPassword,
        ),
      );
      sl<TokenStorage>().saveToken(response.token);
      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
