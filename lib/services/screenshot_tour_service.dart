import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../core/enums/shipment_status.dart';
import '../core/enums/verification_status.dart';
import '../data/api/auth_api.dart';
import '../data/local/hive_database.dart';
import '../data/models/driver_model.dart';
import '../data/models/shipment_model.dart';
import '../data/providers/shipment_provider.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/shell/controllers/main_shell_controller.dart';
import '../routes/app_router.dart';
import '../routes/app_routes.dart';
import 'auth_service.dart';
import 'settings_service.dart';

/// Host-driven screenshot tour. Enable with `--dart-define=SCREENSHOTS=true`.
///
/// Emits `###SCREENSHOT### <name>` lines for [tool/capture_ios_screenshots.sh].
class ScreenshotTourService extends GetxService {
  static const enabled = bool.fromEnvironment('SCREENSHOTS');

  Future<void> start() async {
    if (!enabled) return;

    await Future<void>.delayed(const Duration(milliseconds: 900));
    await _shot('01_splash');

    await _waitForRoute(AppRoutes.onboarding, timeoutMs: 10000);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await _shot('02_onboarding_1');

    if (Get.isRegistered<OnboardingController>()) {
      final c = Get.find<OnboardingController>();
      await c.pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
      c.pageIndex.value = 1;
    }
    await Future<void>.delayed(const Duration(milliseconds: 700));
    await _shot('03_onboarding_2');

    await Get.find<SettingsService>().completeOnboarding();
    AppNavigation.go(AppRoutes.language);
    await _waitForRoute(AppRoutes.language, timeoutMs: 5000);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await _shot('04_language');

    await Get.find<SettingsService>().setLocaleCode('en');
    AppNavigation.go(AppRoutes.login);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    await _shot('05_login');

    AppNavigation.go(AppRoutes.register);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    await _shot('06_register');

    try {
      await _ensureDemoUserAndLogin();
    } catch (e, st) {
      debugPrint('###SCREENSHOT_ERROR### demo_login $e');
      debugPrint('$st');
    }
    await Get.find<SettingsService>().markFabTutorialSeen();
    AppNavigation.go(AppRoutes.shell);
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    await _shot('07_home');

    try {
      final shell = Get.find<MainShellController>();
      shell.changeTab(1);
      AppNavigation.go(AppRoutes.shipments);
      await Future<void>.delayed(const Duration(milliseconds: 800));
      await _shot('08_shipments');

      AppNavigation.push(AppRoutes.shipmentForm);
      await Future<void>.delayed(const Duration(milliseconds: 800));
      await _shot('09_add_shipment');
      AppNavigation.pop();
      await Future<void>.delayed(const Duration(milliseconds: 400));

      shell.changeTab(2);
      AppNavigation.go(AppRoutes.profile);
      await Future<void>.delayed(const Duration(milliseconds: 800));
      await _shot('10_profile');

      shell.changeTab(3);
      AppNavigation.go(AppRoutes.settings);
      await Future<void>.delayed(const Duration(milliseconds: 800));
      await _shot('11_settings');

      AppNavigation.push('${AppRoutes.language}?from=settings');
      await Future<void>.delayed(const Duration(milliseconds: 800));
      await _shot('12_language_settings');
      AppNavigation.pop();
      await Future<void>.delayed(const Duration(milliseconds: 400));

      AppNavigation.push(AppRoutes.driver);
      await Future<void>.delayed(const Duration(milliseconds: 900));
      await _shot('13_driver_verification');
    } catch (e, st) {
      debugPrint('###SCREENSHOT_ERROR### shell_flow $e');
      debugPrint('$st');
    }

    debugPrint('###SCREENSHOT_TOUR_DONE###');
  }

  Future<void> _ensureDemoUserAndLogin() async {
    final api = Get.find<AuthApi>();
    const email = 'demo.driver@stt.com';
    const password = 'stt12345';
    try {
      await api.register(
        email: email,
        password: password,
        displayName: 'Alex Rivera',
        phone: '+1 555 010 2000',
        cdlNumber: 'CDL-482910',
        hub: 'Los Angeles Hub',
      );
    } catch (_) {}

    final user = await api.login(email: email, password: password);
    await Get.find<AuthService>().setSession(user);

    final drivers = HiveDatabase.drivers;
    final existing = drivers.get(user.id);
    if (existing != null) {
      final driver = DriverModel.fromMap(Map<String, dynamic>.from(existing));
      await drivers.put(
        user.id,
        driver.copyWith(status: VerificationStatus.verified).toMap(),
      );
    }

    final provider = ShipmentProvider();
    final now = DateTime.now().toIso8601String();
    final samples = <ShipmentModel>[
      ShipmentModel(
        id: const Uuid().v4(),
        userId: user.id,
        customerName: 'Pacific Retail Co.',
        origin: 'Los Angeles, CA',
        destination: 'Phoenix, AZ',
        status: ShipmentStatus.inTransit,
        createdAt: now,
        updatedAt: now,
      ),
      ShipmentModel(
        id: const Uuid().v4(),
        userId: user.id,
        customerName: 'Desert Foods LLC',
        origin: 'San Diego, CA',
        destination: 'Las Vegas, NV',
        status: ShipmentStatus.pending,
        createdAt: now,
        updatedAt: now,
      ),
      ShipmentModel(
        id: const Uuid().v4(),
        userId: user.id,
        customerName: 'Horizon Parts',
        origin: 'Long Beach, CA',
        destination: 'Tucson, AZ',
        status: ShipmentStatus.delivered,
        createdAt: now,
        updatedAt: now,
      ),
    ];
    for (final s in samples) {
      try {
        await provider.create(s);
      } catch (_) {}
    }
  }

  Future<void> _waitForRoute(String route, {required int timeoutMs}) async {
    final end = DateTime.now().add(Duration(milliseconds: timeoutMs));
    while (DateTime.now().isBefore(end)) {
      final loc = appRouter.routerDelegate.currentConfiguration.uri.path;
      if (loc == route || loc.startsWith(route)) return;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> _shot(String name) async {
    debugPrint('###SCREENSHOT### $name');
    await Future<void>.delayed(const Duration(milliseconds: 1600));
  }
}
