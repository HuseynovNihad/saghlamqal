import '../../domain/entities/daily_meal_check_ins_entity.dart';
import '../models/daily_meal_check_ins_model.dart';

class DailyMealCheckInsMapper {
  DailyMealCheckInsMapper._();

  static DailyMealCheckInsEntity toEntity(DailyMealCheckInsModel model) {
    return DailyMealCheckInsEntity(
      date: model.date,
      dayNumber: model.dayNumber,
      completedMeals: model.completedMeals,
      totalMeals: model.totalMeals,
      completionPercentage: model.completionPercentage,
      meals: model.meals.map(_mealToEntity).toList(),
    );
  }

  static DailyMealEntity _mealToEntity(DailyMealModel model) {
    return DailyMealEntity(
      mealId: model.mealId,
      mealType: model.mealType,
      title: model.title,
      description: model.description,
      time: model.time,
      order: model.order,
      isOptional: model.isOptional,
      checkIn: model.checkIn != null ? checkInToEntity(model.checkIn!) : null,
    );
  }

  static MealCheckInEntity checkInToEntity(MealCheckInModel model) {
    return MealCheckInEntity(
      id: model.id,
      dietPlanMealId: model.dietPlanMealId,
      date: model.date,
      status: model.status,
      note: model.note,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
