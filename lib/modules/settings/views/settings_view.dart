import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/settings_service.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            title: l10n.notifications,
            child: Obx(
              () => SwitchListTile(
                title: Text(l10n.pushNotifications),
                subtitle: Text(l10n.pushNotificationsHint),
                value: controller.notificationsEnabledRx.value,
                onChanged: controller.toggleNotifications,
                activeThumbColor: AppColors.primary,
                activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _card(
            title: l10n.language,
            child: Obx(() {
              Get.find<SettingsService>().localeCodeRx.value;
              return ListTile(
                title: Text(l10n.language),
                subtitle: Text(controller.languageLabel),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                onTap: controller.openLanguage,
              );
            }),
          ),
          const SizedBox(height: 16),
          _card(
            title: l10n.legal,
            child: Column(
              children: [
                ListTile(
                  title: Text(l10n.privacyPolicy),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  onTap: controller.navigateToPrivacyPolicy,
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(l10n.termsOfUse),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  onTap: controller.navigateToTermsOfUse,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            title: l10n.appVersion,
            child: ListTile(
              title: Text(l10n.appVersion),
              subtitle: const Text(AppConstants.appVersion),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.showLogoutDialog,
              icon: const Icon(Icons.logout),
              label: Text(
                l10n.logout,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
