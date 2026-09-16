import '../../domain/entities/my_dietitian_entity.dart';
import '../models/my_dietitian_model.dart';

class MyDietitianMapper {
  MyDietitianMapper._();

  static MyDietitianEntity toEntity(MyDietitianModel model) {
    return MyDietitianEntity(
      id: model.id,
      status: model.status,
      acceptedAt: model.acceptedAt,
      createdAt: model.createdAt,
      dietitian: DietitianInfoEntity(
        id: model.dietitian.id,
        userId: model.dietitian.userId,
        firstName: model.dietitian.firstName,
        lastName: model.dietitian.lastName,
        avatar: model.dietitian.avatar,
        title: model.dietitian.title,
        clinicName: model.dietitian.clinicName,
        profilePhoto: model.dietitian.profilePhoto,
        rating: model.dietitian.rating,
        reviewCount: model.dietitian.reviewCount,
      ),
    );
  }
}
