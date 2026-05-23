import '../../domain/entities/ingredient_entity.dart';
import '../models/ingredient_model.dart';

class IngredientMapper {
  const IngredientMapper._();

  static IngredientEntity toEntity(IngredientModel model) {
    return IngredientEntity(name: model.name, amount: model.amount);
  }

  static IngredientModel toModel(IngredientEntity entity) {
    return IngredientModel(name: entity.name, amount: entity.amount);
  }
}
