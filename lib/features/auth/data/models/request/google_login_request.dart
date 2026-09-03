class GoogleLoginRequest {
  final String idToken;

  const GoogleLoginRequest({required this.idToken});

  Map<String, dynamic> toJson() {
    return {'idToken': idToken};
  }
}
