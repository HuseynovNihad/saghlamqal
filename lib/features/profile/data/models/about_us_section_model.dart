class AboutUsSectionModel {
  final String icon;
  final String title;
  final String text;

  const AboutUsSectionModel({
    required this.icon,
    required this.title,
    required this.text,
  });

  factory AboutUsSectionModel.fromJson(Map<String, dynamic> json) =>
      AboutUsSectionModel(
        icon: json['icon'] as String,
        title: json['title'] as String,
        text: json['text'] as String,
      );
}
