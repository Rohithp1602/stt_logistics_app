import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/modules/splash/controllers/splash_controller.dart';
import 'package:stt_logistics_app/routes/app_routes.dart';

void main() {
  group('resolveSplashDestination', () {
    test('new user → onboarding', () {
      expect(
        resolveSplashDestination(
          onboardingCompleted: false,
          languageSelected: false,
          isLoggedIn: false,
        ),
        AppRoutes.onboarding,
      );
    });

    test('onboarding done, language pending → language', () {
      expect(
        resolveSplashDestination(
          onboardingCompleted: true,
          languageSelected: false,
          isLoggedIn: false,
        ),
        AppRoutes.language,
      );
    });

    test('setup complete, logged out → login', () {
      expect(
        resolveSplashDestination(
          onboardingCompleted: true,
          languageSelected: true,
          isLoggedIn: false,
        ),
        AppRoutes.login,
      );
    });

    test('setup complete, logged in → shell', () {
      expect(
        resolveSplashDestination(
          onboardingCompleted: true,
          languageSelected: true,
          isLoggedIn: true,
        ),
        AppRoutes.shell,
      );
    });
  });
}
