class UpdateProfileRequestModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const UpdateProfileRequestModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }
}
