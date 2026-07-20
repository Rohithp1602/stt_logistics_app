import 'package:get/get.dart';

import '../../../constants/analytics_events.dart';
import '../../../routes/app_routes.dart';
import '../../../services/analytics_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/messaging_service.dart';
import '../../../services/performance_service.dart';
import '../../../services/screenshot_tour_service.dart';
import '../../../services/settings_service.dart';

/// Pure first-run routing used by [SplashController] (easy to unit test).
String resolveSplashDestination({
  required bool onboardingCompleted,
  required bool languageSelected,
  required bool isLoggedIn,
}) {
  if (!onboardingCompleted) return AppRoutes.onboarding;
  if (!languageSelected) return AppRoutes.language;
  return isLoggedIn ? AppRoutes.shell : AppRoutes.login;
}

/// Decides the first screen after the splash delay.
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final analytics = Get.isRegistered<AnalyticsService>()
        ? Get.find<AnalyticsService>()
        : null;
    final performance = Get.isRegistered<PerformanceService>()
        ? Get.find<PerformanceService>()
        : null;

    await analytics?.logEvent(AnalyticsEvents.flowSplashStart);
    final trace =
        await performance?.startTrace(PerformanceTraces.splashBootstrap);

    await Future<void>.delayed(const Duration(milliseconds: 1200));

    if (ScreenshotTourService.enabled) {
      // Extra hold so the host can capture the splash frame.
      await Future<void>.delayed(const Duration(milliseconds: 2200));
    }

    final auth = Get.find<AuthService>();
    await auth.restoreSession();

    final settings = Get.find<SettingsService>();
    final destination = resolveSplashDestination(
      onboardingCompleted: settings.onboardingCompleted,
      languageSelected: settings.languageSelected,
      isLoggedIn: auth.isLoggedIn,
    );

    await analytics?.logEvent(
      AnalyticsEvents.flowSplashComplete,
      parameters: <String, Object>{
        'destination': AnalyticsScreens.fromRoute(destination),
      },
    );
    await performance?.stopTrace(trace);

    Get.offAllNamed(destination);

    if (destination == AppRoutes.shell &&
        Get.isRegistered<MessagingService>()) {
      await Get.find<MessagingService>().handlePendingNavigation();
    }
  }
}
