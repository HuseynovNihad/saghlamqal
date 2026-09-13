part of 'dietitian_invites_bloc.dart';

abstract class DietitianInvitesEvent extends Equatable {
  const DietitianInvitesEvent();

  @override
  List<Object?> get props => [];
}

class DietitianInvitesRequested extends DietitianInvitesEvent {
  const DietitianInvitesRequested();
}

class DietitianInviteAccepted extends DietitianInvitesEvent {
  final String inviteId;

  const DietitianInviteAccepted(this.inviteId);

  @override
  List<Object?> get props => [inviteId];
}

class DietitianInviteRejected extends DietitianInvitesEvent {
  final String inviteId;

  const DietitianInviteRejected(this.inviteId);

  @override
  List<Object?> get props => [inviteId];
}
