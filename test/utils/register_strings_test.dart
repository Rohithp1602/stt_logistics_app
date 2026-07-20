import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/constants/app_strings.dart';

void main() {
  test('register strings match approved copy', () {
    expect(AppStrings.registerTitle, 'Create account');
    expect(AppStrings.registerButton, 'Create account');
    expect(AppStrings.registerNow, 'Register now');
    expect(AppStrings.alreadyHaveAccount, 'Already have an account?');
    expect(AppStrings.signInLink, 'Sign in');
    expect(AppStrings.dontHaveAccount, "Don't have an account?");
    expect(
      AppStrings.emailExists,
      'An account with this email already exists',
    );
    expect(AppStrings.photoOptionalHint, 'Profile photo (optional)');
    expect(AppStrings.addPhotoHint, 'Tap to add a photo');
    expect(AppStrings.changePhotoHint, 'Tap to change photo');
    expect(AppStrings.fullNameHint, 'Full name');
    expect(AppStrings.phoneHint, 'Phone number');
    expect(AppStrings.confirmPasswordHint, 'Confirm password');
    expect(AppStrings.cdlHint, 'CDL number');
    expect(AppStrings.hubHint, 'Hub / depot');
    expect(AppStrings.invalidPhone, 'Enter a valid phone number');
    expect(AppStrings.passwordsDoNotMatch, 'Passwords do not match');
  });
}
