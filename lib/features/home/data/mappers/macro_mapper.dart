import '../../domain/entities/macro_entity.dart';
import '../models/macro_model.dart';

MacroEntity macroToEntity(MacroModel model) {
  return MacroEntity(
    label: model.label,
    recommended: model.recommended,
    unit: model.unit,
  );
}

MacroModel macroToModel(MacroEntity entity) {
  return MacroModel(
    label: entity.label,
    recommended: entity.recommended,
    unit: entity.unit,
  );
}
