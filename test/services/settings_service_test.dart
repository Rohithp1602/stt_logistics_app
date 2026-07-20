import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:stt_logistics_app/data/local/hive_boxes.dart';
import 'package:stt_logistics_app/services/settings_service.dart';

void main() {
  group('SettingsService', () {
    late SettingsService settingsService;
    Box? settingsBox;

    setUpAll(() async {
      final dir = Directory.systemTemp.createTempSync('stt_settings_');
      Hive.init(dir.path);
      try {
        settingsBox = await Hive.openBox(HiveBoxes.settings);
      } catch (_) {
        settingsBox = Hive.box(HiveBoxes.settings);
      }
    });

    setUp(() async {
      // Clear any existing data before each test
      await settingsBox?.clear();
      
      // Reset GetX
      Get.reset();
      
      // Initialize service
      settingsService = SettingsService();
      Get.put(settingsService, permanent: true);
      settingsService.onInit();
    });

    tearDown(() async {
      await settingsBox?.clear();
      Get.reset();
    });

    tearDownAll(() async {
      await settingsBox?.close();
      await Hive.close();
    });

    test('should initialize with default notifications enabled', () {
      expect(settingsService.notificationsEnabled, isTrue);
      expect(settingsService.notificationsEnabledRx.value, isTrue);
    });

    test('should persist and toggle notifications setting', () async {
      // Initially enabled
      expect(settingsService.notificationsEnabled, isTrue);

      // Disable notifications
      await settingsService.setNotificationsEnabled(false);
      expect(settingsService.notificationsEnabled, isFalse);
      expect(settingsService.notificationsEnabledRx.value, isFalse);

      // Verify persistence in Hive
      expect(settingsBox?.get('notifications_enabled'), isFalse);

      // Enable notifications again
      await settingsService.setNotificationsEnabled(true);
      expect(settingsService.notificationsEnabled, isTrue);
      expect(settingsService.notificationsEnabledRx.value, isTrue);

      // Verify persistence in Hive
      expect(settingsBox?.get('notifications_enabled'), isTrue);
    });

    test('should toggle notifications using toggleNotificationsEnabled', () async {
      // Initially enabled
      expect(settingsService.notificationsEnabled, isTrue);

      // Toggle to disable
      await settingsService.toggleNotificationsEnabled();
      expect(settingsService.notificationsEnabled, isFalse);

      // Toggle to enable
      await settingsService.toggleNotificationsEnabled();
      expect(settingsService.notificationsEnabled, isTrue);
    });

    test('should restore notifications setting from Hive on initialization', () async {
      // Pre-populate Hive with disabled notifications
      await settingsBox?.put('notifications_enabled', false);

      // Create new service instance
      final newService = SettingsService();
      Get.reset();
      Get.put(newService, permanent: true);
      newService.onInit();

      // Should restore the disabled state
      expect(newService.notificationsEnabled, isFalse);
      expect(newService.notificationsEnabledRx.value, isFalse);
    });

    test('should use default value if no setting exists in Hive', () async {
      // Ensure no existing setting
      expect(settingsBox?.get('notifications_enabled'), isNull);

      // Create new service instance
      final newService = SettingsService();
      Get.reset();
      Get.put(newService, permanent: true);
      newService.onInit();

      // Should use default (enabled)
      expect(newService.notificationsEnabled, isTrue);
      expect(newService.notificationsEnabledRx.value, isTrue);
    });

    test('first-run flags default to false', () {
      expect(settingsService.onboardingCompleted, isFalse);
      expect(settingsService.languageSelected, isFalse);
      expect(settingsService.fabTutorialSeen, isFalse);
      expect(settingsService.localeCode, 'en');
    });

    test('completeOnboarding persists flag', () async {
      await settingsService.completeOnboarding();
      expect(settingsService.onboardingCompleted, isTrue);
      expect(settingsBox?.get('onboarding_completed'), isTrue);
    });

    test('setLocaleCode persists locale and marks language selected', () async {
      await settingsService.setLocaleCode('hi');
      expect(settingsService.localeCode, 'hi');
      expect(settingsService.languageSelected, isTrue);
      expect(settingsBox?.get('locale_code'), 'hi');
      expect(settingsBox?.get('language_selected'), isTrue);
    });

    test('markFabTutorialSeen persists flag', () async {
      await settingsService.markFabTutorialSeen();
      expect(settingsService.fabTutorialSeen, isTrue);
      expect(settingsBox?.get('fab_tutorial_seen'), isTrue);
    });
  });
}