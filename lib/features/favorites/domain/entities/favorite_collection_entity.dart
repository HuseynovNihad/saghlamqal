// favorite_collection_entity.dart
class FavoriteCollectionEntity {
  final String id;
  final String name;
  final String? icon;
  final String? description;
  final int itemCount;
  final DateTime createdAt;

  const FavoriteCollectionEntity({
    required this.id,
    required this.name,
    this.icon,
    this.description,
    required this.itemCount,
    required this.createdAt,
  });

  FavoriteCollectionEntity copyWith({
    String? id,
    String? name,
    String? icon,
    String? description,
    int? itemCount,
    DateTime? createdAt,
  }) {
    return FavoriteCollectionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      itemCount: itemCount ?? this.itemCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCollectionEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
