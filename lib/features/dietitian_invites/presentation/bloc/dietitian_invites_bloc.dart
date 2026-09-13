import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/dietitian_invite_entity.dart';
import '../../domain/usecases/accept_dietitian_invite.dart';
import '../../domain/usecases/get_dietitian_invites.dart';
import '../../domain/usecases/reject_dietitian_invite.dart';

part 'dietitian_invites_event.dart';
part 'dietitian_invites_state.dart';

class DietitianInvitesBloc
    extends Bloc<DietitianInvitesEvent, DietitianInvitesState> {
  final GetDietitianInvites getDietitianInvites;
  final AcceptDietitianInvite acceptDietitianInvite;
  final RejectDietitianInvite rejectDietitianInvite;

  List<DietitianInviteEntity> _invites = [];

  DietitianInvitesBloc({
    required this.getDietitianInvites,
    required this.acceptDietitianInvite,
    required this.rejectDietitianInvite,
  }) : super(const DietitianInvitesInitial()) {
    on<DietitianInvitesRequested>(_onRequested);
    on<DietitianInviteAccepted>(_onAccepted);
    on<DietitianInviteRejected>(_onRejected);
  }

  Future<void> _onRequested(
    DietitianInvitesRequested event,
    Emitter<DietitianInvitesState> emit,
  ) async {
    emit(const DietitianInvitesLoading());

    try {
      final invites = await getDietitianInvites();

      _invites = invites;

      emit(DietitianInvitesLoaded(invites: invites));
    } catch (e) {
      emit(DietitianInvitesError(message: e.toString()));
    }
  }

  Future<void> _onAccepted(
    DietitianInviteAccepted event,
    Emitter<DietitianInvitesState> emit,
  ) async {
    emit(
      DietitianInviteActionLoading(invites: _invites, inviteId: event.inviteId),
    );

    try {
      await acceptDietitianInvite(event.inviteId);

      _invites = _invites
          .where((invite) => invite.id != event.inviteId)
          .toList();

      emit(
        DietitianInviteActionSuccess(
          invites: _invites,
          message: 'Dietoloq dəvəti qəbul edildi',
        ),
      );

      emit(DietitianInvitesLoaded(invites: _invites));
    } catch (e) {
      emit(DietitianInvitesError(message: e.toString()));

      emit(DietitianInvitesLoaded(invites: _invites));
    }
  }

  Future<void> _onRejected(
    DietitianInviteRejected event,
    Emitter<DietitianInvitesState> emit,
  ) async {
    emit(
      DietitianInviteActionLoading(invites: _invites, inviteId: event.inviteId),
    );

    try {
      await rejectDietitianInvite(event.inviteId);

      _invites = _invites
          .where((invite) => invite.id != event.inviteId)
          .toList();

      emit(
        DietitianInviteActionSuccess(
          invites: _invites,
          message: 'Dietoloq dəvəti rədd edildi',
        ),
      );

      emit(DietitianInvitesLoaded(invites: _invites));
    } catch (e) {
      emit(DietitianInvitesError(message: e.toString()));

      emit(DietitianInvitesLoaded(invites: _invites));
    }
  }
}
