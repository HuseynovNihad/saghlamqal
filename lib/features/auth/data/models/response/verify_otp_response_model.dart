import '../../../../../shared/models/nutrition_model.dart';

import '../../../domain/entities/verify_otp_response_entity.dart';

import 'user_model.dart';

class VerifyOtpResponseModel extends VerifyOtpResponseEntity {
  const VerifyOtpResponseModel({
    required super.token,
    required super.refreshToken,
    required super.user,
    super.nutrition,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    final nutritionJson = json['nutrition'];

    return VerifyOtpResponseModel(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      nutrition: nutritionJson != null
          ? NutritionModel.fromJson(nutritionJson as Map<String, dynamic>)
          : null,
    );
  }
}
