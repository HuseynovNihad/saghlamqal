class AppValidators {
  static String? isNotEmpty(String? value, {required String message}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  static String? email(
    String? value, {
    required String requiredMessage,
    required String invalidMessage,
  }) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return requiredMessage;
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (!regex.hasMatch(v)) {
      return invalidMessage;
    }

    return null;
  }

  static String? password(
    String? value, {
    required String requiredMessage,
    required String minLengthMessage,
  }) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return requiredMessage;
    }

    if (v.length < 6) {
      return minLengthMessage;
    }

    return null;
  }

  static String? phone(
    String? value, {
    required String requiredMessage,
    required String digitsOnlyMessage,
    required String invalidMessage,
  }) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return requiredMessage;
    }

    final digitsOnly = RegExp(r'^\d+$');

    if (!digitsOnly.hasMatch(v)) {
      return digitsOnlyMessage;
    }

    if (v.length < 9 || v.length > 15) {
      return invalidMessage;
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
