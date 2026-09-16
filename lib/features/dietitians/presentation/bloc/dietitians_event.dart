part of 'dietitians_bloc.dart';

abstract class DietitiansEvent {}

// ─── Page ──────────────────────────────────────────────────

class DietitiansRequested extends DietitiansEvent {}

class DietitiansRefreshed extends DietitiansEvent {}

// ─── Invites ───────────────────────────────────────────────

class DietitianInviteAccepted extends DietitiansEvent {
  final String inviteId;

  DietitianInviteAccepted({
    required this.inviteId,
  });
}

class DietitianInviteRejected extends DietitiansEvent {
  final String inviteId;

  DietitianInviteRejected({
    required this.inviteId,
  });
}

// ─── Diet Plan ─────────────────────────────────────────────

class DietPlanHistoryRequested extends DietitiansEvent {}

class DietPlanCheckInsRequested extends DietitiansEvent {
  final String date;

  DietPlanCheckInsRequested({
    required this.date,
  });
}

class MealCheckInUpdated extends DietitiansEvent {
  final UpdateMealCheckInParams params;

  MealCheckInUpdated({
    required this.params,
  });
}