import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../l10n/app_locales.dart';
import '../../../l10n/l10n.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../../utils/snackbar_helper.dart';

class SettingsController extends GetxController {
  final SettingsService _settingsService = Get.find<SettingsService>();
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  bool get notificationsEnabled => _settingsService.notificationsEnabled;
  RxBool get notificationsEnabledRx => _settingsService.notificationsEnabledRx;

  String get languageLabel =>
      AppLocales.byStorageCode(_settingsService.localeCode).nativeName;

  Future<void> toggleNotifications(bool enabled) async {
    await _settingsService.setNotificationsEnabled(enabled);
  }

  void openLanguage() {
    AppNavigation.push('${AppRoutes.language}?from=settings');
  }

  Future<void> showLogoutDialog() async {
    final strings = l10n;
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text(strings.confirmLogout),
        content: Text(strings.confirmLogoutBody),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(strings.cancel),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(strings.logout),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _authRepository.logout();
        AppNavigation.go(AppRoutes.login);
        SnackbarHelper.infoAfterNav(strings.logoutSuccess);
      } catch (_) {
        SnackbarHelper.error(strings.logoutFailed);
      }
    }
  }

  void navigateToPrivacyPolicy() => AppNavigation.push(AppRoutes.legalPrivacy);

  void navigateToTermsOfUse() => AppNavigation.push(AppRoutes.legalTerms);
}
