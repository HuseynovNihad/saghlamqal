import 'package:get_it/get_it.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/delete_account_usecase.dart';
import 'domain/usecases/forgot_password_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/login_with_token_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/resend_otp_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/verify_otp_usecase.dart';
import 'domain/usecases/request_restore_account_usecase.dart';
import 'domain/usecases/verify_restore_account_usecase.dart';
import 'presentation/bloc/auth_bloc.dart';

Future<void> initAuth(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // ─────────────────────────────────────────────────────────────
  // REPOSITORY
  // ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // ─────────────────────────────────────────────────────────────
  // USE CASES
  // ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => LoginWithTokenUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => RegisterUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => ResendOtpUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => LogoutUsecase(sl<IAuthRepository>()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl<IAuthRepository>()));
  sl.registerLazySingleton(
    () => RequestRestoreAccountUsecase(sl<IAuthRepository>()),
  ); // ✅
  sl.registerLazySingleton(
    () => VerifyRestoreAccountUsecase(sl<IAuthRepository>()),
  ); // ✅

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────
  sl.registerFactory(
    () => AuthBloc(
      login: sl<LoginUsecase>(),
      loginWithToken: sl<LoginWithTokenUsecase>(),
      register: sl<RegisterUsecase>(),
      verifyOtp: sl<VerifyOtpUsecase>(),
      resendOtp: sl<ResendOtpUsecase>(),
      forgotPassword: sl<ForgotPasswordUsecase>(),
      resetPassword: sl<ResetPasswordUsecase>(),
      logout: sl<LogoutUsecase>(),
      deleteAccount: sl<DeleteAccountUseCase>(),
      requestRestoreAccount: sl<RequestRestoreAccountUsecase>(),
      verifyRestoreAccount: sl<VerifyRestoreAccountUsecase>(),
    ),
  );
}
