class AppValidator {
  AppValidator._();

  // Email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Field Required
  static String? fieldRequired(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      if (fieldName != null && fieldName.isNotEmpty) {
        return "$fieldName field is required";
      } else {
        return "This field is required";
      }
    }
    return null;
  }

  // Password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 3) {
      return "Password must be at least 3 character long.";
    }
    return null;
  }

  // Password
  static String? noValidation(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }
}
