import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_locales.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/settings_service.dart';

class LanguageController extends GetxController {
  final selectedCode = 'en'.obs;
  final isSubmitting = false.obs;
  late final bool fromSettings;

  @override
  void onInit() {
    super.onInit();
    fromSettings = Get.arguments == 'settings';
    selectedCode.value = Get.find<SettingsService>().localeCode;
  }

  void select(String code) => selectedCode.value = code;

  Future<void> confirm() async {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    try {
      await Get.find<SettingsService>().setLocaleCode(selectedCode.value);
      if (fromSettings) {
        if (Get.key.currentState?.canPop() ?? false) {
          Get.back();
        }
        return;
      }
      final auth = Get.find<AuthService>();
      final dest = auth.isLoggedIn ? AppRoutes.shell : AppRoutes.login;
      Get.offAllNamed(dest);
    } finally {
      // Keep disabled if we navigated away; reset if still on this screen.
      if (!isClosed) isSubmitting.value = false;
    }
  }
}

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController());
  }
}

/// First-run / settings language picker.
class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.chooseLanguage),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: controller.fromSettings,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              l10n.chooseLanguageHint,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Obx(() {
              final selectedCode = controller.selectedCode.value;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: AppLocales.all.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final option = AppLocales.all[index];
                  final selected = selectedCode == option.storageCode;
                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => controller.select(option.storageCode),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? AppColors.accent
                                : AppColors.border,
                            width: selected ? 1.6 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option.nativeName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    option.englishName,
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              selected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: selected
                                  ? AppColors.accent
                                  : AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.isSubmitting.value ? null : controller.confirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.accent.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      controller.fromSettings
                          ? l10n.navDone
                          : l10n.continueLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
