import '../../constants/app_constants.dart';
import '../../l10n/l10n.dart';
import '../extensions/string_extensions.dart';

/// Shared form validators for auth and shipment forms.
///
/// Returns `null` when valid; otherwise a user-facing error message.
class FormValidators {
  FormValidators._();

  /// Ensures the field is not empty after trimming whitespace.
  static String? required(String? value, {String? message}) {
    if (value == null || value.isBlank) {
      return message ?? l10n.fieldRequired;
    }
    return null;
  }

  /// Validates email presence and basic format.
  static String? email(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;
    if (!value!.isValidEmail) return l10n.invalidEmail;
    return null;
  }

  /// Validates password presence and minimum length.
  static String? password(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;
    if (value!.trim().length < AppConstants.minPasswordLength) {
      return l10n.passwordTooShort;
    }
    return null;
  }

  /// Validates phone presence and basic digit count (10–15 digits).
  static String? phone(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;
    if (!value!.isValidPhone) return l10n.invalidPhone;
    return null;
  }

  /// Ensures confirmation matches the original password.
  static String? confirmPassword(String password, String? confirm) {
    final requiredError = required(confirm);
    if (requiredError != null) return requiredError;
    if (confirm!.trim() != password.trim()) {
      return l10n.passwordsDoNotMatch;
    }
    return null;
  }

  /// Ensures origin and destination are both present and not the same.
  static String? originDestination(String? origin, String? destination) {
    final originError = required(origin);
    if (originError != null) return originError;

    final destinationError = required(destination);
    if (destinationError != null) return destinationError;

    if (origin!.trim().toLowerCase() == destination!.trim().toLowerCase()) {
      return l10n.originSameAsDestination;
    }
    return null;
  }
}
