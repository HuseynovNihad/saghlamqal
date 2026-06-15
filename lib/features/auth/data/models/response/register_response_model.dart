import '../../../domain/entities/register_response_entity.dart';

class RegisterResponseModel extends RegisterResponseEntity {
  RegisterResponseModel({required super.message});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(message: json['message'] as String);
  }
}
