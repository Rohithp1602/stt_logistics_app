/// Common string helpers used by forms and display logic.
extension StringExtensions on String {
  /// Returns `true` when the string has no non-whitespace characters.
  bool get isBlank => trim().isEmpty;

  /// Returns `true` when the string looks like a basic email address.
  bool get isValidEmail {
    final pattern = RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[\w\-]{2,}$');
    return pattern.hasMatch(trim());
  }

  /// Returns only the digit characters in the string.
  String get digitsOnly => replaceAll(RegExp(r'\D'), '');

  /// Returns `true` when the string contains a plausible phone number.
  bool get isValidPhone {
    final digits = digitsOnly;
    return digits.length >= 10 && digits.length <= 15;
  }
}
