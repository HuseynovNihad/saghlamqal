part of 'dietitian_invites_bloc.dart';

abstract class DietitianInvitesState extends Equatable {
  const DietitianInvitesState();

  @override
  List<Object?> get props => [];
}

class DietitianInvitesInitial extends DietitianInvitesState {
  const DietitianInvitesInitial();
}

class DietitianInvitesLoading extends DietitianInvitesState {
  const DietitianInvitesLoading();
}

class DietitianInvitesLoaded extends DietitianInvitesState {
  final List<DietitianInviteEntity> invites;

  const DietitianInvitesLoaded({required this.invites});

  @override
  List<Object?> get props => [invites];
}

class DietitianInviteActionLoading extends DietitianInvitesState {
  final List<DietitianInviteEntity> invites;
  final String inviteId;

  const DietitianInviteActionLoading({
    required this.invites,
    required this.inviteId,
  });

  @override
  List<Object?> get props => [invites, inviteId];
}

class DietitianInviteActionSuccess extends DietitianInvitesState {
  final List<DietitianInviteEntity> invites;
  final String message;

  const DietitianInviteActionSuccess({
    required this.invites,
    required this.message,
  });

  @override
  List<Object?> get props => [invites, message];
}

class DietitianInvitesError extends DietitianInvitesState {
  final String message;

  const DietitianInvitesError({required this.message});

  @override
  List<Object?> get props => [message];
}
