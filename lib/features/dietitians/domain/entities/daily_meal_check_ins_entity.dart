class DailyMealCheckInsEntity {
  final String date;
  final int dayNumber;
  final int completedMeals;
  final int totalMeals;
  final double completionPercentage;
  final List<DailyMealEntity> meals;

  const DailyMealCheckInsEntity({
    required this.date,
    required this.dayNumber,
    required this.completedMeals,
    required this.totalMeals,
    required this.completionPercentage,
    required this.meals,
  });
}

class DailyMealEntity {
  final String mealId;
  final String mealType;
  final String title;
  final String? description;
  final String time;
  final int order;
  final bool isOptional;
  final MealCheckInEntity? checkIn;

  const DailyMealEntity({
    required this.mealId,
    required this.mealType,
    required this.title,
    this.description,
    required this.time,
    required this.order,
    required this.isOptional,
    this.checkIn,
  });
}

class MealCheckInEntity {
  final String id;
  final String dietPlanMealId;
  final String date;
  final String status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MealCheckInEntity({
    required this.id,
    required this.dietPlanMealId,
    required this.date,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
}
