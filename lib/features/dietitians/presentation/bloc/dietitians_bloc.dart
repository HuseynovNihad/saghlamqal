import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/update_meal_check_in_params.dart';
import '../../domain/entities/daily_meal_check_ins_entity.dart';
import '../../domain/entities/dietitian_invite_entity.dart';
import '../../domain/entities/my_dietitian_entity.dart';
import '../../domain/entities/patient_diet_plan_entity.dart';

import '../../domain/usecases/accept_dietitian_invite_usecase.dart';
import '../../domain/usecases/get_active_diet_plan_usecase.dart';
import '../../domain/usecases/get_dietitian_invites_usecase.dart';
import '../../domain/usecases/get_diet_plan_check_ins_usecase.dart';
import '../../domain/usecases/get_diet_plan_history_usecase.dart';
import '../../domain/usecases/get_my_dietitian_usecase.dart';
import '../../domain/usecases/reject_dietitian_invite_usecase.dart';
import '../../domain/usecases/update_meal_check_in_usecase.dart';

part 'dietitians_event.dart';
part 'dietitians_state.dart';

class DietitiansBloc extends Bloc<DietitiansEvent, DietitiansState> {
  final GetMyDietitianUseCase _getMyDietitianUseCase;
  final GetDietitianInvitesUseCase _getDietitianInvitesUseCase;
  final AcceptDietitianInviteUseCase _acceptDietitianInviteUseCase;
  final RejectDietitianInviteUseCase _rejectDietitianInviteUseCase;

  final GetActiveDietPlanUseCase _getActiveDietPlanUseCase;
  final GetDietPlanHistoryUseCase _getDietPlanHistoryUseCase;
  final GetDietPlanCheckInsUseCase _getDietPlanCheckInsUseCase;
  final UpdateMealCheckInUseCase _updateMealCheckInUseCase;

  DietitiansBloc({
    required GetMyDietitianUseCase getMyDietitianUseCase,
    required GetDietitianInvitesUseCase getDietitianInvitesUseCase,
    required AcceptDietitianInviteUseCase acceptDietitianInviteUseCase,
    required RejectDietitianInviteUseCase rejectDietitianInviteUseCase,
    required GetActiveDietPlanUseCase getActiveDietPlanUseCase,
    required GetDietPlanHistoryUseCase getDietPlanHistoryUseCase,
    required GetDietPlanCheckInsUseCase getDietPlanCheckInsUseCase,
    required UpdateMealCheckInUseCase updateMealCheckInUseCase,
  }) : _getMyDietitianUseCase = getMyDietitianUseCase,
       _getDietitianInvitesUseCase = getDietitianInvitesUseCase,
       _acceptDietitianInviteUseCase = acceptDietitianInviteUseCase,
       _rejectDietitianInviteUseCase = rejectDietitianInviteUseCase,
       _getActiveDietPlanUseCase = getActiveDietPlanUseCase,
       _getDietPlanHistoryUseCase = getDietPlanHistoryUseCase,
       _getDietPlanCheckInsUseCase = getDietPlanCheckInsUseCase,
       _updateMealCheckInUseCase = updateMealCheckInUseCase,
       super(DietitiansInitial()) {
    on<DietitiansRequested>(_onRequested);
    on<DietitiansRefreshed>(_onRefreshed);
    on<DietitianInviteAccepted>(_onInviteAccepted);
    on<DietitianInviteRejected>(_onInviteRejected);
    on<DietPlanHistoryRequested>(_onDietPlanHistoryRequested);
    on<DietPlanCheckInsRequested>(_onDietPlanCheckInsRequested);
    on<MealCheckInUpdated>(_onMealCheckInUpdated);
  }

  Future<void> _onRequested(
    DietitiansRequested event,
    Emitter<DietitiansState> emit,
  ) async {
    emit(DietitiansLoading());

    try {
      final data = await _loadMainData();

      emit(
        DietitiansLoaded(
          myDietitian: data.myDietitian,
          invites: data.invites,
          activeDietPlan: data.activeDietPlan,
          dailyCheckIns: data.dailyCheckIns,
        ),
      );
    } catch (e) {
      emit(DietitiansError(message: e.toString()));
    }
  }

  Future<void> _onRefreshed(
    DietitiansRefreshed event,
    Emitter<DietitiansState> emit,
  ) async {
    try {
      final data = await _loadMainData();

      emit(
        DietitiansLoaded(
          myDietitian: data.myDietitian,
          invites: data.invites,
          activeDietPlan: data.activeDietPlan,
          dailyCheckIns: data.dailyCheckIns,
        ),
      );
    } catch (e) {
      emit(DietitiansError(message: e.toString()));
    }
  }

  Future<void> _onInviteAccepted(
    DietitianInviteAccepted event,
    Emitter<DietitiansState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DietitiansLoaded) {
      return;
    }

    emit(
      currentState.copyWith(
        actionLoadingInviteId: event.inviteId,
        clearMessage: true,
      ),
    );

    try {
      await _acceptDietitianInviteUseCase(event.inviteId);

      final data = await _loadMainData();

      emit(
        DietitiansLoaded(
          myDietitian: data.myDietitian,
          invites: data.invites,
          activeDietPlan: data.activeDietPlan,
          dailyCheckIns: data.dailyCheckIns,
          message: 'Dəvət qəbul edildi',
        ),
      );
    } catch (e) {
      final latestState = state;

      if (latestState is DietitiansLoaded) {
        emit(
          latestState.copyWith(clearActionLoading: true, message: e.toString()),
        );
      }
    }
  }

  Future<void> _onInviteRejected(
    DietitianInviteRejected event,
    Emitter<DietitiansState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DietitiansLoaded) {
      return;
    }

    emit(
      currentState.copyWith(
        actionLoadingInviteId: event.inviteId,
        clearMessage: true,
      ),
    );

    try {
      await _rejectDietitianInviteUseCase(event.inviteId);

      final invites = await _getDietitianInvitesUseCase();

      final latestState = state;

      if (latestState is! DietitiansLoaded) {
        return;
      }

      emit(
        latestState.copyWith(
          invites: invites,
          clearActionLoading: true,
          message: 'Dəvət rədd edildi',
        ),
      );
    } catch (e) {
      final latestState = state;

      if (latestState is DietitiansLoaded) {
        emit(
          latestState.copyWith(clearActionLoading: true, message: e.toString()),
        );
      }
    }
  }

  Future<void> _onDietPlanHistoryRequested(
    DietPlanHistoryRequested event,
    Emitter<DietitiansState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DietitiansLoaded) {
      return;
    }

    emit(currentState.copyWith(isHistoryLoading: true, clearMessage: true));

    try {
      final history = await _getDietPlanHistoryUseCase();

      final latestState = state;

      if (latestState is! DietitiansLoaded) {
        return;
      }

      emit(
        latestState.copyWith(dietPlanHistory: history, isHistoryLoading: false),
      );
    } catch (e) {
      final latestState = state;

      if (latestState is DietitiansLoaded) {
        emit(
          latestState.copyWith(isHistoryLoading: false, message: e.toString()),
        );
      }
    }
  }

  Future<void> _onDietPlanCheckInsRequested(
    DietPlanCheckInsRequested event,
    Emitter<DietitiansState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DietitiansLoaded) {
      return;
    }

    emit(
      currentState.copyWith(
        isCheckInsLoading: true,
        clearMessage: true,
        clearDailyCheckIns: true,
      ),
    );

    try {
      final checkIns = await _getDietPlanCheckInsUseCase(event.date);

      final latestState = state;

      if (latestState is! DietitiansLoaded) {
        return;
      }

      emit(
        latestState.copyWith(dailyCheckIns: checkIns, isCheckInsLoading: false),
      );
    } catch (e) {
      final latestState = state;

      if (latestState is DietitiansLoaded) {
        emit(
          latestState.copyWith(isCheckInsLoading: false, message: e.toString()),
        );
      }
    }
  }

  Future<void> _onMealCheckInUpdated(
    MealCheckInUpdated event,
    Emitter<DietitiansState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DietitiansLoaded) {
      return;
    }

    emit(
      currentState.copyWith(
        updatingMealId: event.params.dietPlanMealId,
        clearMessage: true,
      ),
    );

    try {
      await _updateMealCheckInUseCase(event.params);

      final checkIns = await _getDietPlanCheckInsUseCase(event.params.date);

      final latestState = state;

      if (latestState is! DietitiansLoaded) {
        return;
      }

      emit(
        latestState.copyWith(
          dailyCheckIns: checkIns,
          clearMealLoading: true,
          message: 'Yemək statusu yeniləndi',
        ),
      );
    } catch (e) {
      final latestState = state;

      if (latestState is DietitiansLoaded) {
        emit(
          latestState.copyWith(clearMealLoading: true, message: e.toString()),
        );
      }
    }
  }

  Future<_DietitiansMainData> _loadMainData() async {
    final results = await Future.wait<dynamic>([
      _getMyDietitianUseCase(),
      _getDietitianInvitesUseCase(),
      _getActiveDietPlanUseCase(),
    ]);

    final myDietitian = results[0] as MyDietitianEntity?;
    final invites = results[1] as List<DietitianInviteEntity>;
    final activeDietPlan = results[2] as PatientDietPlanEntity?;

    DailyMealCheckInsEntity? dailyCheckIns;

    if (activeDietPlan != null) {
      try {
        dailyCheckIns = await _getDietPlanCheckInsUseCase(_today());
      } catch (_) {
        dailyCheckIns = null;
      }
    }

    return _DietitiansMainData(
      myDietitian: myDietitian,
      invites: invites,
      activeDietPlan: activeDietPlan,
      dailyCheckIns: dailyCheckIns,
    );
  }

  String _today() {
    final now = DateTime.now();

    final year = now.year.toString().padLeft(4, '0');
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}

class _DietitiansMainData {
  final MyDietitianEntity? myDietitian;
  final List<DietitianInviteEntity> invites;
  final PatientDietPlanEntity? activeDietPlan;
  final DailyMealCheckInsEntity? dailyCheckIns;

  const _DietitiansMainData({
    required this.myDietitian,
    required this.invites,
    required this.activeDietPlan,
    required this.dailyCheckIns,
  });
}
