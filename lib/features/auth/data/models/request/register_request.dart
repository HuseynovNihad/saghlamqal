class RegisterRequest {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;

  const RegisterRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
