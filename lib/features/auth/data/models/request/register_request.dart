class RegisterRequest {
  final String email;
  final String firstName;
  final String lastName;
  final DateTime birthday;
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
    required this.birthday,
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
      "birthday": birthday.toIso8601String(),
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
