class AppValidators {
  static String? isNotEmpty(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? "Bu sahə boş qala bilməz";
    }
    return null;
  }

  static String? email(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return "E-poçt daxil edin";
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (!regex.hasMatch(v)) {
      return "Düzgün e-poçt ünvanı daxil edin";
    }

    return null;
  }

  static String? password(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return "Şifrə daxil edin";
    }

    if (v.length < 6) {
      return "Şifrə ən az 6 simvoldan ibarət olmalıdır";
    }

    return null;
  }

  static String? phone(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return "Telefon nömrəsi daxil edin";
    }

    final digitsOnly = RegExp(r'^\d+$');

    if (!digitsOnly.hasMatch(v)) {
      return "Telefon yalnız rəqəmlərdən ibarət olmalıdır";
    }

    if (v.length < 9 || v.length > 15) {
      return "Düzgün telefon nömrəsi daxil edin";
    }

    return null;
  }

  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
