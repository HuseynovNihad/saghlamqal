part of 'dietitians_bloc.dart';

abstract class DietitiansState {}

class DietitiansInitial extends DietitiansState {}

class DietitiansLoading extends DietitiansState {}

class DietitiansLoaded extends DietitiansState {
  final MyDietitianEntity? myDietitian;
  final List<DietitianInviteEntity> invites;

  // Diet Plan
  final PatientDietPlanEntity? activeDietPlan;
  final List<PatientDietPlanEntity> dietPlanHistory;
  final DailyMealCheckInsEntity? dailyCheckIns;

  // Loading states
  final String? actionLoadingInviteId;
  final String? updatingMealId;

  final bool isHistoryLoading;
  final bool isCheckInsLoading;

  // UI message
  final String? message;

  DietitiansLoaded({
    required this.myDietitian,
    required this.invites,
    this.activeDietPlan,
    this.dietPlanHistory = const [],
    this.dailyCheckIns,
    this.actionLoadingInviteId,
    this.updatingMealId,
    this.isHistoryLoading = false,
    this.isCheckInsLoading = false,
    this.message,
  });

  // ───────────────────────────────────────────────────────
  // HELPERS
  // ───────────────────────────────────────────────────────

  bool get hasDietitian => myDietitian != null;

  bool get hasInvites => invites.isNotEmpty;

  bool get hasActiveDietPlan => activeDietPlan != null;

  bool isInviteLoading(String inviteId) {
    return actionLoadingInviteId == inviteId;
  }

  bool isMealUpdating(String mealId) {
    return updatingMealId == mealId;
  }

  // ───────────────────────────────────────────────────────
  // COPY WITH
  // ───────────────────────────────────────────────────────

  DietitiansLoaded copyWith({
    MyDietitianEntity? myDietitian,
    List<DietitianInviteEntity>? invites,
    PatientDietPlanEntity? activeDietPlan,
    List<PatientDietPlanEntity>? dietPlanHistory,
    DailyMealCheckInsEntity? dailyCheckIns,
    String? actionLoadingInviteId,
    String? updatingMealId,
    bool? isHistoryLoading,
    bool? isCheckInsLoading,
    String? message,

    bool clearMyDietitian = false,
    bool clearActiveDietPlan = false,
    bool clearActionLoading = false,
    bool clearMealLoading = false,
    bool clearMessage = false,
    bool clearDailyCheckIns = false,
  }) {
    return DietitiansLoaded(
      myDietitian: clearMyDietitian ? null : myDietitian ?? this.myDietitian,

      invites: invites ?? this.invites,

      activeDietPlan: clearActiveDietPlan
          ? null
          : activeDietPlan ?? this.activeDietPlan,

      dietPlanHistory: dietPlanHistory ?? this.dietPlanHistory,

      dailyCheckIns: clearDailyCheckIns
          ? null
          : dailyCheckIns ?? this.dailyCheckIns,

      actionLoadingInviteId: clearActionLoading
          ? null
          : actionLoadingInviteId ?? this.actionLoadingInviteId,

      updatingMealId: clearMealLoading
          ? null
          : updatingMealId ?? this.updatingMealId,

      isHistoryLoading: isHistoryLoading ?? this.isHistoryLoading,

      isCheckInsLoading: isCheckInsLoading ?? this.isCheckInsLoading,

      message: clearMessage ? null : message ?? this.message,
    );
  }
}

class DietitiansError extends DietitiansState {
  final String message;

  DietitiansError({required this.message});
}
