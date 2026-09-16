import '../../domain/entities/patient_diet_plan_entity.dart';
import '../models/patient_diet_plan_model.dart';

class PatientDietPlanMapper {
  PatientDietPlanMapper._();

  static PatientDietPlanEntity toEntity(PatientDietPlanModel model) {
    return PatientDietPlanEntity(
      id: model.id,
      patientId: model.patientId,
      assignedByDietitianId: model.assignedByDietitianId,
      startDate: model.startDate,
      endDate: model.endDate,
      notes: model.notes,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      dietPlan: _dietPlanToEntity(model.dietPlan),
    );
  }

  static List<PatientDietPlanEntity> toEntityList(
    List<PatientDietPlanModel> models,
  ) {
    return models.map(toEntity).toList();
  }

  static DietPlanEntity _dietPlanToEntity(DietPlanModel model) {
    return DietPlanEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      startDate: model.startDate,
      endDate: model.endDate,
      durationDays: model.durationDays,
      status: model.status,
      notes: model.notes,
      days: model.days.map(_dayToEntity).toList(),
    );
  }

  static DietPlanDayEntity _dayToEntity(DietPlanDayModel model) {
    return DietPlanDayEntity(
      id: model.id,
      dayNumber: model.dayNumber,
      meals: model.meals.map(_mealToEntity).toList(),
    );
  }

  static DietPlanMealEntity _mealToEntity(DietPlanMealModel model) {
    return DietPlanMealEntity(
      id: model.id,
      mealType: model.mealType,
      title: model.title,
      description: model.description,
      time: model.time,
      notes: model.notes,
      order: model.order,
      isOptional: model.isOptional,
      foods: model.foods.map(_foodToEntity).toList(),
    );
  }

  static DietPlanFoodEntity _foodToEntity(DietPlanFoodModel model) {
    return DietPlanFoodEntity(
      id: model.id,
      foodName: model.foodName,
      quantity: model.quantity,
      unit: model.unit,
      calories: model.calories,
      protein: model.protein,
      carbs: model.carbs,
      fat: model.fat,
      notes: model.notes,
      order: model.order,
    );
  }
}
