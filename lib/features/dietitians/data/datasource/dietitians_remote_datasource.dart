
import '../../../../core/network/endpoints.dart';
import '../../../../core/network/models/network_exceptions.dart';
import '../../../../core/network/network_manager.dart';
import '../models/daily_meal_check_ins_model.dart';
import '../models/dietitian_invite_model.dart';
import '../models/my_dietitian_model.dart';
import '../models/patient_diet_plan_model.dart';
import '../models/update_meal_check_in_params.dart';

abstract class DietitiansRemoteDataSource {
  // ─── My Dietitian ────────────────────────────────────────

  Future<MyDietitianModel?> getMyDietitian();

  // ─── Invites ─────────────────────────────────────────────

  Future<List<DietitianInviteModel>> getInvites();

  Future<void> acceptInvite(String inviteId);

  Future<void> rejectInvite(String inviteId);

  // ─── Diet Plan ───────────────────────────────────────────

  Future<PatientDietPlanModel?> getActiveDietPlan();

  Future<List<PatientDietPlanModel>> getDietPlanHistory();

  Future<DailyMealCheckInsModel> getDietPlanCheckIns(String date);

  Future<MealCheckInModel> updateMealCheckIn(UpdateMealCheckInParams params);
}

class DietitiansRemoteDataSourceImpl implements DietitiansRemoteDataSource {
  final NetworkManager _networkManager;

  const DietitiansRemoteDataSourceImpl(this._networkManager);

  // ─── My Dietitian ────────────────────────────────────────

  @override
  Future<MyDietitianModel?> getMyDietitian() async {
    final response = await _networkManager.get<dynamic>(
      Endpoints.getMyDietitian,
    );

    final data = response.data;

    // Aktiv dietoloq yoxdursa backend
    // null və ya boş response qaytara bilər.
    if (data == null) {
      return null;
    }

    if (data is String) {
      if (data.trim().isEmpty) {
        return null;
      }

      throw AppException('My dietitian response formatı yanlışdır.');
    }

    if (data is! Map<String, dynamic>) {
      throw AppException('My dietitian response formatı yanlışdır.');
    }

    return MyDietitianModel.fromJson(data);
  }

  // ─── Invites ─────────────────────────────────────────────

  @override
  Future<List<DietitianInviteModel>> getInvites() async {
    final response = await _networkManager.get<List<dynamic>>(
      Endpoints.getDietitianInvites,
    );

    final data = response.data;

    if (data == null) {
      return [];
    }

    return data
        .map(
          (item) => DietitianInviteModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> acceptInvite(String inviteId) async {
    await _networkManager.patch(Endpoints.acceptDietitianInvite(inviteId));
  }

  @override
  Future<void> rejectInvite(String inviteId) async {
    await _networkManager.patch(Endpoints.rejectDietitianInvite(inviteId));
  }

  // ─── Diet Plan ───────────────────────────────────────────

  @override
  Future<PatientDietPlanModel?> getActiveDietPlan() async {
    try {
      final response = await _networkManager.get<Map<String, dynamic>>(
        Endpoints.getActiveDietPlan,
      );

      final data = response.data;

      if (data == null) {
        return null;
      }

      return PatientDietPlanModel.fromJson(data);
    } on AppException catch (e) {
      // Aktiv diet planın olmaması normal vəziyyətdir.
      if (e.statusCode == 404) {
        return null;
      }

      rethrow;
    }
  }

  @override
  Future<List<PatientDietPlanModel>> getDietPlanHistory() async {
    final response = await _networkManager.get<List<dynamic>>(
      Endpoints.getDietPlanHistory,
    );

    final data = response.data;

    if (data == null) {
      return [];
    }

    return data
        .map(
          (item) => PatientDietPlanModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<DailyMealCheckInsModel> getDietPlanCheckIns(String date) async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.getDietPlanCheckIns,
      queryParameters: {'date': date},
    );

    final data = response.data;

    if (data == null) {
      throw AppException('Yemək məlumatları tapılmadı.');
    }

    return DailyMealCheckInsModel.fromJson(data);
  }

  @override
  Future<MealCheckInModel> updateMealCheckIn(
    UpdateMealCheckInParams params,
  ) async {
    final response = await _networkManager.post<Map<String, dynamic>>(
      Endpoints.updateDietPlanCheckIn,
      data: {
        'dietPlanMealId': params.dietPlanMealId,
        'date': params.date,
        'status': params.status,
        if (params.note != null) 'note': params.note,
      },
    );

    final data = response.data;

    if (data == null) {
      throw AppException('Yemək statusu yenilənə bilmədi.');
    }

    return MealCheckInModel.fromJson(data);
  }
}
