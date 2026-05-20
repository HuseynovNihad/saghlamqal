class FavoriteCollectionEntity {
  final String id;
  final String name;
  final String emoji;
  final int itemCount;
  final DateTime createdAt;

  const FavoriteCollectionEntity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.itemCount,
    required this.createdAt,
  });

  FavoriteCollectionEntity copyWith({
    String? id,
    String? name,
    String? emoji,
    int? itemCount,
    DateTime? createdAt,
  }) {
    return FavoriteCollectionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
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