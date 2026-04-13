// lib/features/scan/data/models/product_model.dart
import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.barcode,
    required super.name,
    super.brand,
    super.imageUrl,
    super.calories,
    super.protein,
    super.carbs,
    super.fat,
  });

  factory ProductModel.fromJson(String barcode, Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>? ?? {};
    final nutriments = product['nutriments'] as Map<String, dynamic>? ?? {};

    return ProductModel(
      barcode: barcode,
      name:
          product['product_name'] as String? ??
          product['product_name_en'] as String? ??
          'Naməlum məhsul',
      brand: product['brands'] as String?,
      imageUrl: product['image_front_url'] as String?,
      calories: (nutriments['energy-kcal_100g'] as num?)?.toDouble(),
      protein: (nutriments['proteins_100g'] as num?)?.toDouble(),
      carbs: (nutriments['carbohydrates_100g'] as num?)?.toDouble(),
      fat: (nutriments['fat_100g'] as num?)?.toDouble(),
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      barcode: entity.barcode,
      name: entity.name,
      brand: entity.brand,
      imageUrl: entity.imageUrl,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
    );
  }
}
