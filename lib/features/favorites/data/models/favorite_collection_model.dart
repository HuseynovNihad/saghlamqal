class FavoriteCollectionModel {
  final String id;
  final String name;
  final String iconAsset;
  final String createdAt;

  const FavoriteCollectionModel({
    required this.id,
    required this.name,
    required this.iconAsset,
    required this.createdAt,
  });

  factory FavoriteCollectionModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCollectionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconAsset: json['icon_asset'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon_asset': iconAsset,
    'created_at': createdAt,
  };
}
