class FavoriteCollectionEntity {
  final String id;
  final String name;
  final String iconAsset;
  final int itemCount;
  final DateTime createdAt;

  const FavoriteCollectionEntity({
    required this.id,
    required this.name,
    required this.iconAsset,
    required this.itemCount,
    required this.createdAt,
  });

  FavoriteCollectionEntity copyWith({
    String? id,
    String? name,
    String? iconAsset,
    int? itemCount,
    DateTime? createdAt,
  }) {
    return FavoriteCollectionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      iconAsset: iconAsset ?? this.iconAsset,
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
