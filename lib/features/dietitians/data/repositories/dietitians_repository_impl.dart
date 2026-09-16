import '../../domain/entities/daily_meal_check_ins_entity.dart';
import '../../domain/entities/dietitian_invite_entity.dart';
import '../../domain/entities/my_dietitian_entity.dart';
import '../../domain/entities/patient_diet_plan_entity.dart';
import '../../domain/repositories/dietitians_repository.dart';
import '../datasource/dietitians_remote_datasource.dart';
import '../mappers/daily_meal_check_ins_mapper.dart';
import '../mappers/dietitian_invite_mapper.dart';
import '../mappers/my_dietitian_mapper.dart';
import '../mappers/patient_diet_plan_mapper.dart';
import '../models/update_meal_check_in_params.dart';

class DietitiansRepositoryImpl implements DietitiansRepository {
  final DietitiansRemoteDataSource _remoteDataSource;

  const DietitiansRepositoryImpl(this._remoteDataSource);

  // ─── My Dietitian ────────────────────────────────────────

  @override
  Future<MyDietitianEntity?> getMyDietitian() async {
    final model = await _remoteDataSource.getMyDietitian();

    if (model == null) {
      return null;
    }

    return MyDietitianMapper.toEntity(model);
  }

  // ─── Invites ─────────────────────────────────────────────

  @override
  Future<List<DietitianInviteEntity>> getInvites() async {
    final models = await _remoteDataSource.getInvites();

    return DietitianInviteMapper.toEntityList(models);
  }

  @override
  Future<void> acceptInvite(String inviteId) async {
    await _remoteDataSource.acceptInvite(inviteId);
  }

  @override
  Future<void> rejectInvite(String inviteId) async {
    await _remoteDataSource.rejectInvite(inviteId);
  }

  // ─── Diet Plan ───────────────────────────────────────────

  @override
  Future<PatientDietPlanEntity?> getActiveDietPlan() async {
    final model = await _remoteDataSource.getActiveDietPlan();

    if (model == null) {
      return null;
    }

    return PatientDietPlanMapper.toEntity(model);
  }

  @override
  Future<List<PatientDietPlanEntity>> getDietPlanHistory() async {
    final models = await _remoteDataSource.getDietPlanHistory();

    return PatientDietPlanMapper.toEntityList(models);
  }

  @override
  Future<DailyMealCheckInsEntity> getDietPlanCheckIns(String date) async {
    final model = await _remoteDataSource.getDietPlanCheckIns(date);

    return DailyMealCheckInsMapper.toEntity(model);
  }

  @override
  Future<MealCheckInEntity> updateMealCheckIn(
    UpdateMealCheckInParams params,
  ) async {
    final model = await _remoteDataSource.updateMealCheckIn(params);

    return DailyMealCheckInsMapper.checkInToEntity(model);
  }
}
