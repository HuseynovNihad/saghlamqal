class DailyMealCheckInsModel {
  final String date;
  final int dayNumber;
  final int completedMeals;
  final int totalMeals;
  final double completionPercentage;
  final List<DailyMealModel> meals;

  const DailyMealCheckInsModel({
    required this.date,
    required this.dayNumber,
    required this.completedMeals,
    required this.totalMeals,
    required this.completionPercentage,
    required this.meals,
  });

  factory DailyMealCheckInsModel.fromJson(Map<String, dynamic> json) {
    return DailyMealCheckInsModel(
      date: json['date']?.toString() ?? '',
      dayNumber: (json['dayNumber'] as num?)?.toInt() ?? 0,
      completedMeals: (json['completedMeals'] as num?)?.toInt() ?? 0,
      totalMeals: (json['totalMeals'] as num?)?.toInt() ?? 0,
      completionPercentage:
          (json['completionPercentage'] as num?)?.toDouble() ?? 0,
      meals: (json['meals'] as List<dynamic>? ?? [])
          .map((item) => DailyMealModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DailyMealModel {
  final String mealId;
  final String mealType;
  final String title;
  final String? description;
  final String time;
  final int order;
  final bool isOptional;
  final MealCheckInModel? checkIn;

  const DailyMealModel({
    required this.mealId,
    required this.mealType,
    required this.title,
    this.description,
    required this.time,
    required this.order,
    required this.isOptional,
    this.checkIn,
  });

  factory DailyMealModel.fromJson(Map<String, dynamic> json) {
    final checkInJson = json['checkIn'];

    return DailyMealModel(
      mealId: json['mealId'].toString(),
      mealType: json['mealType']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description'] as String?,
      time: json['time']?.toString() ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
      isOptional: json['isOptional'] as bool? ?? false,
      checkIn: checkInJson is Map<String, dynamic>
          ? MealCheckInModel.fromJson(checkInJson)
          : null,
    );
  }
}

class MealCheckInModel {
  final String id;
  final String dietPlanMealId;
  final String date;
  final String status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MealCheckInModel({
    required this.id,
    required this.dietPlanMealId,
    required this.date,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealCheckInModel.fromJson(Map<String, dynamic> json) {
    return MealCheckInModel(
      id: json['id'].toString(),
      dietPlanMealId: json['dietPlanMealId'].toString(),
      date: json['date'].toString(),
      status: json['status'].toString(),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: DateTime.parse(json['updatedAt'].toString()),
    );
  }
}
