import '../../data/models/update_meal_check_in_params.dart';
import '../entities/daily_meal_check_ins_entity.dart';
import '../entities/dietitian_invite_entity.dart';
import '../entities/my_dietitian_entity.dart';
import '../entities/patient_diet_plan_entity.dart';

abstract class DietitiansRepository {
  // ─── My Dietitian ────────────────────────────────────────

  Future<MyDietitianEntity?> getMyDietitian();

  // ─── Invites ─────────────────────────────────────────────

  Future<List<DietitianInviteEntity>> getInvites();

  Future<void> acceptInvite(String inviteId);

  Future<void> rejectInvite(String inviteId);

  // ─── Diet Plan ───────────────────────────────────────────

  Future<PatientDietPlanEntity?> getActiveDietPlan();

  Future<List<PatientDietPlanEntity>> getDietPlanHistory();

  Future<DailyMealCheckInsEntity> getDietPlanCheckIns(String date);

  Future<MealCheckInEntity> updateMealCheckIn(UpdateMealCheckInParams params);
}
