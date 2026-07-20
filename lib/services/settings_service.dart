import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_boxes.dart';
import '../l10n/app_locales.dart';
import 'messaging_service.dart';

/// App preferences stored in Hive (notifications, locale, first-run flags).
class SettingsService extends GetxService {
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _languageSelectedKey = 'language_selected';
  static const String _localeCodeKey = 'locale_code';
  static const String _fabTutorialSeenKey = 'fab_tutorial_seen';

  Box get _box => Hive.box(HiveBoxes.settings);

  final RxBool notificationsEnabledRx = true.obs;
  final RxBool onboardingCompletedRx = false.obs;
  final RxBool languageSelectedRx = false.obs;
  final RxBool fabTutorialSeenRx = false.obs;
  final RxString localeCodeRx = 'en'.obs;

  bool get notificationsEnabled => notificationsEnabledRx.value;
  bool get onboardingCompleted => onboardingCompletedRx.value;
  bool get languageSelected => languageSelectedRx.value;
  bool get fabTutorialSeen => fabTutorialSeenRx.value;
  String get localeCode => localeCodeRx.value;

  Locale get locale => AppLocales.byStorageCode(localeCode).locale;

  @override
  void onInit() {
    super.onInit();
    notificationsEnabledRx.value =
        (_box.get(_notificationsEnabledKey) as bool?) ?? true;
    onboardingCompletedRx.value =
        (_box.get(_onboardingCompletedKey) as bool?) ?? false;
    languageSelectedRx.value =
        (_box.get(_languageSelectedKey) as bool?) ?? false;
    fabTutorialSeenRx.value =
        (_box.get(_fabTutorialSeenKey) as bool?) ?? false;
    localeCodeRx.value = (_box.get(_localeCodeKey) as String?) ?? 'en';
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _box.put(_notificationsEnabledKey, enabled);
    notificationsEnabledRx.value = enabled;
    if (Get.isRegistered<MessagingService>()) {
      final messaging = Get.find<MessagingService>();
      if (enabled) {
        await messaging.enable();
      } else {
        await messaging.disable();
      }
    }
  }

  Future<void> toggleNotificationsEnabled() async {
    await setNotificationsEnabled(!notificationsEnabled);
  }

  Future<void> completeOnboarding() async {
    await _box.put(_onboardingCompletedKey, true);
    onboardingCompletedRx.value = true;
  }

  Future<void> setLocaleCode(String code, {bool markSelected = true}) async {
    await _box.put(_localeCodeKey, code);
    localeCodeRx.value = code;
    if (markSelected) {
      await _box.put(_languageSelectedKey, true);
      languageSelectedRx.value = true;
    }
    final locale = AppLocales.byStorageCode(code).locale;
    // Only when a navigator exists (skip during bare unit-test setUp).
    if (Get.key.currentState != null) {
      Get.updateLocale(locale);
    }
  }

  Future<void> markFabTutorialSeen() async {
    await _box.put(_fabTutorialSeenKey, true);
    fabTutorialSeenRx.value = true;
  }
}
