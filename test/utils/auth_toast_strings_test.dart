import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/constants/app_strings.dart';

void main() {
  test('auth toast strings match approved copy', () {
    expect(AppStrings.loginSuccess, 'Login successful');
    expect(AppStrings.loginFailed, 'Invalid email or password');
    expect(AppStrings.logoutSuccess, 'Logged out successfully');
    expect(AppStrings.logoutFailed, 'Logout failed');
    expect(AppStrings.registerSuccess, 'Registration successful');
    expect(AppStrings.registerFailed, 'Registration failed');
  });
}
