class FavoriteCollectionModel {
  final String id;
  final String name;
  final String emoji;
  final String createdAt;

  const FavoriteCollectionModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.createdAt,
  });

  factory FavoriteCollectionModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCollectionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'emoji': emoji,
    'created_at': createdAt,
  };
}
