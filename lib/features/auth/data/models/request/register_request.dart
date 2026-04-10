class RegisterRequest {
  final String email;
  final String firstName;
  final String lastName;
  final int age;
  final double weight;
  final double height;
  final String gender;
  final String activityLevel;
  final String password;
  final String confirmPassword;

  RegisterRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "age": age,
      "weight": weight,
      "height": height,
      "gender": gender,
      "activityLevel": activityLevel,
      "password": password,
      "confirmPassword": confirmPassword,
    };
  }
}
