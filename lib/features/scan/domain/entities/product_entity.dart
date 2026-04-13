class ProductEntity {
  final String barcode;
  final String name;
  final String? brand;
  final String? imageUrl;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;

  const ProductEntity({
    required this.barcode,
    required this.name,
    this.brand,
    this.imageUrl,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
  });
}
