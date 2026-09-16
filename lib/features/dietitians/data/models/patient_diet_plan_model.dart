class PatientDietPlanModel {
  final String id;
  final String patientId;
  final String assignedByDietitianId;
  final String startDate;
  final String endDate;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DietPlanModel dietPlan;

  const PatientDietPlanModel({
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

  factory PatientDietPlanModel.fromJson(Map<String, dynamic> json) {
    return PatientDietPlanModel(
      id: json['id'].toString(),
      patientId: json['patientId'].toString(),
      assignedByDietitianId: json['assignedByDietitianId'].toString(),
      startDate: json['startDate'].toString(),
      endDate: json['endDate'].toString(),
      notes: json['notes'] as String?,
      status: json['status'].toString(),
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: DateTime.parse(json['updatedAt'].toString()),
      dietPlan: DietPlanModel.fromJson(
        json['dietPlan'] as Map<String, dynamic>,
      ),
    );
  }
}

class DietPlanModel {
  final String id;
  final String title;
  final String? description;
  final String startDate;
  final String endDate;
  final int durationDays;
  final String status;
  final String? notes;
  final List<DietPlanDayModel> days;

  const DietPlanModel({
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

  factory DietPlanModel.fromJson(Map<String, dynamic> json) {
    return DietPlanModel(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      description: json['description'] as String?,
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      durationDays: (json['durationDays'] as num?)?.toInt() ?? 0,
      status: json['status']?.toString() ?? '',
      notes: json['notes'] as String?,
      days: (json['days'] as List<dynamic>? ?? [])
          .map(
            (item) => DietPlanDayModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class DietPlanDayModel {
  final String id;
  final int dayNumber;
  final List<DietPlanMealModel> meals;

  const DietPlanDayModel({
    required this.id,
    required this.dayNumber,
    required this.meals,
  });

  factory DietPlanDayModel.fromJson(Map<String, dynamic> json) {
    return DietPlanDayModel(
      id: json['id'].toString(),
      dayNumber: (json['dayNumber'] as num?)?.toInt() ?? 0,
      meals: (json['meals'] as List<dynamic>? ?? [])
          .map(
            (item) => DietPlanMealModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class DietPlanMealModel {
  final String id;
  final String mealType;
  final String title;
  final String? description;
  final String time;
  final String? notes;
  final int order;
  final bool isOptional;
  final List<DietPlanFoodModel> foods;

  const DietPlanMealModel({
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

  factory DietPlanMealModel.fromJson(Map<String, dynamic> json) {
    return DietPlanMealModel(
      id: json['id'].toString(),
      mealType: json['mealType']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description'] as String?,
      time: json['time']?.toString() ?? '',
      notes: json['notes'] as String?,
      order: (json['order'] as num?)?.toInt() ?? 0,
      isOptional: json['isOptional'] as bool? ?? false,
      foods: (json['foods'] as List<dynamic>? ?? [])
          .map(
            (item) => DietPlanFoodModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class DietPlanFoodModel {
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

  const DietPlanFoodModel({
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

  factory DietPlanFoodModel.fromJson(Map<String, dynamic> json) {
    return DietPlanFoodModel(
      id: json['id'].toString(),
      foodName: json['foodName']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
      unit: json['unit']?.toString() ?? '',
      calories: (json['calories'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );
  }
}
