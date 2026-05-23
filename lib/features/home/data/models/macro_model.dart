class MacroModel {
  final String label;
  final int recommended;
  final String unit;

  const MacroModel({
    required this.label,
    required this.recommended,
    required this.unit,
  });

  factory MacroModel.fromJson(Map<String, dynamic> json) {
    return MacroModel(
      label: json['label'] as String,
      recommended: json['recommended'] as int,
      unit: json['unit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'recommended': recommended, 'unit': unit};
  }
}
