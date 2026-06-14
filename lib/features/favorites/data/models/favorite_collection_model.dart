class FavoriteCollectionModel {
  final String id;
  final String name;
  final String? icon;
  final String? description;
  final String createdAt;

  const FavoriteCollectionModel({
    required this.id,
    required this.name,
    this.icon,
    this.description,
    required this.createdAt,
  });

  factory FavoriteCollectionModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCollectionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon': icon,
    'description': description,
    'createdAt': createdAt,
  };
}
