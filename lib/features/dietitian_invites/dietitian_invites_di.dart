import 'package:get_it/get_it.dart';

import 'data/datasource/dietitian_invites_remote_datasource.dart';
import 'data/repositories/dietitian_invites_repository_impl.dart';
import 'domain/repositories/dietitian_invites_repository.dart';
import 'domain/usecases/accept_dietitian_invite.dart';
import 'domain/usecases/get_dietitian_invites.dart';
import 'domain/usecases/reject_dietitian_invite.dart';
import 'presentation/bloc/dietitian_invites_bloc.dart';

Future<void> initDietitianInvites(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<DietitianInvitesRemoteDataSource>(
    () => DietitianInvitesRemoteDataSourceImpl(networkManager: sl()),
  );

  // ─────────────────────────────────────────────────────────────
  // REPOSITORY
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<DietitianInvitesRepository>(
    () => DietitianInvitesRepositoryImpl(
      remoteDataSource: sl<DietitianInvitesRemoteDataSource>(),
    ),
  );

  // ─────────────────────────────────────────────────────────────
  // USE CASES
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton(
    () => GetDietitianInvites(sl<DietitianInvitesRepository>()),
  );

  sl.registerLazySingleton(
    () => AcceptDietitianInvite(sl<DietitianInvitesRepository>()),
  );

  sl.registerLazySingleton(
    () => RejectDietitianInvite(sl<DietitianInvitesRepository>()),
  );

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<DietitianInvitesBloc>(
    () => DietitianInvitesBloc(
      getDietitianInvites: sl<GetDietitianInvites>(),
      acceptDietitianInvite: sl<AcceptDietitianInvite>(),
      rejectDietitianInvite: sl<RejectDietitianInvite>(),
    ),
  );
}
