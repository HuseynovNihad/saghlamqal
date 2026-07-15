class RegisterRequest {
  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final DateTime birthday;
  final int age;
  final double weight;
  final double targetWeight;
  final double height;
  final String gender;
  final String activityLevel;
  final String goal;
  final String password;
  final String confirmPassword;

  RegisterRequest({
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.age,
    required this.weight,
    required this.targetWeight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.goal,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "phoneNumber": phoneNumber,
      "firstName": firstName,
      "lastName": lastName,
      "birthday": birthday.toIso8601String(),
      "age": age,
      "weight": weight,
      "targetWeight": targetWeight,
      "height": height,
      "gender": gender,
      "activityLevel": activityLevel,
      "goal": goal,
      "password": password,
      "confirmPassword": confirmPassword,
    };
  }
}
