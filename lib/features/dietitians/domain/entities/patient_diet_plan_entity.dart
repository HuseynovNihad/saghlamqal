class PatientDietPlanEntity {
  final String id;
  final String patientId;
  final String assignedByDietitianId;
  final String startDate;
  final String endDate;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DietPlanEntity dietPlan;

  const PatientDietPlanEntity({
    required this.id,
    required this.patientId,
    required this.assignedByDietitianId,
    required this.startDate,
    required this.endDate,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.dietPlan,
  });
}

class DietPlanEntity {
  final String id;
  final String title;
  final String? description;
  final String startDate;
  final String endDate;
  final int durationDays;
  final String status;
  final String? notes;
  final List<DietPlanDayEntity> days;

  const DietPlanEntity({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.status,
    this.notes,
    required this.days,
  });
}

class DietPlanDayEntity {
  final String id;
  final int dayNumber;
  final List<DietPlanMealEntity> meals;

  const DietPlanDayEntity({
    required this.id,
    required this.dayNumber,
    required this.meals,
  });
}

class DietPlanMealEntity {
  final String id;
  final String mealType;
  final String title;
  final String? description;
  final String time;
  final String? notes;
  final int order;
  final bool isOptional;
  final List<DietPlanFoodEntity> foods;

  const DietPlanMealEntity({
    required this.id,
    required this.mealType,
    required this.title,
    this.description,
    required this.time,
    this.notes,
    required this.order,
    required this.isOptional,
    required this.foods,
  });
}

class DietPlanFoodEntity {
  final String id;
  final String foodName;
  final double quantity;
  final String unit;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final String? notes;
  final int order;

  const DietPlanFoodEntity({
    required this.id,
    required this.foodName,
    required this.quantity,
    required this.unit,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.notes,
    required this.order,
  });
}
