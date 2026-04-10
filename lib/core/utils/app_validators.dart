class AppValidators {
  static String? isNotEmpty(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? "Bu sahə boş qala bilməz";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "E-poçt daxil edin";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Düzgün e-poçt ünvanı daxil edin";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifrə daxil edin";
    }
    if (value.length < 6) {
      return "Şifrə ən az 6 simvoldan ibarət olmalıdır";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Telefon nömrəsi daxil edin";
    }
    if (value.length < 9) {
      return "Düzgün telefon nömrəsi daxil edin";
    }
    return null;
  }
}
