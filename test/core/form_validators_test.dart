import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/core/validators/form_validators.dart';
import 'package:stt_logistics_app/l10n/app_localizations.dart';

void main() {
  final en = lookupAppLocalizations(const Locale('en'));

  group('FormValidators.phone', () {
    test('returns null for valid phone numbers', () {
      expect(FormValidators.phone('5551234567'), isNull);
      expect(FormValidators.phone('(555) 123-4567'), isNull);
      expect(FormValidators.phone('+1 555 123 4567'), isNull);
    });

    test('returns required error for blank input', () {
      expect(FormValidators.phone(null), en.fieldRequired);
      expect(FormValidators.phone('   '), en.fieldRequired);
    });

    test('returns invalid phone for too few digits', () {
      expect(FormValidators.phone('12345'), en.invalidPhone);
    });
  });

  group('FormValidators.confirmPassword', () {
    test('returns null when passwords match', () {
      expect(FormValidators.confirmPassword('secret1', 'secret1'), isNull);
      expect(FormValidators.confirmPassword(' secret1 ', 'secret1'), isNull);
    });

    test('returns required error for blank confirm', () {
      expect(
        FormValidators.confirmPassword('secret1', null),
        en.fieldRequired,
      );
    });

    test('returns mismatch error when passwords differ', () {
      expect(
        FormValidators.confirmPassword('secret1', 'secret2'),
        en.passwordsDoNotMatch,
      );
    });
  });
}
