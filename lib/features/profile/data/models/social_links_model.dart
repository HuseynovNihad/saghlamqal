class SocialLinksModel {
  final String email;
  final String website;
  final String instagram;

  const SocialLinksModel({
    required this.email,
    required this.website,
    required this.instagram,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) =>
      SocialLinksModel(
        email: json['email'] as String,
        website: json['website'] as String,
        instagram: json['instagram'] as String,
      );
}
