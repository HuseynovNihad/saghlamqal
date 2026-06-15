import '../../../../../shared/models/nutrition_model.dart';
import '../../../domain/entities/verify_otp_response_entity.dart';
import 'user_model.dart';

class VerifyOtpResponseModel extends VerifyOtpResponseEntity {
  const VerifyOtpResponseModel({
    required super.token,
    required super.refreshToken,
    required super.user,
    required super.nutrition,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserModel.fromJson(json['user']),
      nutrition: NutritionModel.fromJson(json['nutrition']),
    );
  }
}
