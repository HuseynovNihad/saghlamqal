class RecentProductModel {
  final String name;
  final String? imageUrl;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;

  const RecentProductModel({
    required this.name,
    this.imageUrl,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory RecentProductModel.fromJson(Map<String, dynamic> json) {
    return RecentProductModel(
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      calories: json['calories'] as int,
      protein: json['protein'] as int,
      carbs: json['carbs'] as int,
      fat: json['fat'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': imageUrl,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }
}
