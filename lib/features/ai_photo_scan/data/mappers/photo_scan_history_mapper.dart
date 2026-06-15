import '../../domain/entities/photo_scan_history_entity.dart';
import '../models/photo_scan_history_model.dart';

class PhotoScanHistoryMapper {
  const PhotoScanHistoryMapper._();

  static PhotoScanHistoryEntity toEntity(PhotoScanHistoryModel model) {
    return PhotoScanHistoryEntity(
      id: model.id,
      name: model.name,
      calories: model.calories,
      protein: model.protein,
      carbs: model.carbs,
      fat: model.fat,
      vitamins: model.vitamins,
      advice: model.advice,
      isFood: model.isFood,
      servingSize: model.servingSize,
      servingUnit: model.servingUnit,
      createdAt: DateTime.parse(model.createdAt),
    );
  }

  static List<PhotoScanHistoryEntity> toEntityList(
    List<PhotoScanHistoryModel> models,
  ) => models.map(toEntity).toList();
}
