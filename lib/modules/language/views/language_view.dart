import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_locales.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/settings_service.dart';
import '../../../widgets/responsive_page.dart';

class LanguageController extends GetxController {
  LanguageController({this.fromSettings = false});

  final selectedCode = 'en'.obs;
  final isSubmitting = false.obs;
  final bool fromSettings;

  @override
  void onInit() {
    super.onInit();
    selectedCode.value = Get.find<SettingsService>().localeCode;
  }

  void select(String code) {
    selectedCode.value = code;
    // Apply immediately so chrome strings update on web; post-frame avoids
    // nested rebuilds during the InkWell tap handler.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isClosed) return;
      Get.find<SettingsService>().setLocaleCode(code, markSelected: false);
    });
  }

  Future<void> confirm() async {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    try {
      await Get.find<SettingsService>().setLocaleCode(selectedCode.value);
      if (fromSettings) {
        AppNavigation.pop();
        return;
      }
      final auth = Get.find<AuthService>();
      final dest = auth.isLoggedIn ? AppRoutes.shell : AppRoutes.login;
      AppNavigation.go(dest);
    } finally {
      if (!isClosed) isSubmitting.value = false;
    }
  }
}

class LanguageBinding extends Bindings {
  LanguageBinding({this.fromSettings = false});

  final bool fromSettings;

  @override
  void dependencies() {
    if (Get.isRegistered<LanguageController>()) {
      Get.delete<LanguageController>(force: true);
    }
    Get.put(LanguageController(fromSettings: fromSettings));
  }
}

/// First-run / settings language picker.
class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key, this.returnToSettings = false});

  final bool returnToSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bp = ResponsivePage.breakpointOf(context);
    final crossAxisCount = switch (bp) {
      AppBreakpoint.desktop => 3,
      AppBreakpoint.tablet => 2,
      AppBreakpoint.mobile => 1,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.chooseLanguage),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: controller.fromSettings,
      ),
      body: ResponsivePage(
        maxWidth: bp == AppBreakpoint.desktop ? 960 : 720,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                bp == AppBreakpoint.mobile ? 16 : 28,
                20,
                bp == AppBreakpoint.mobile ? 16 : 28,
                8,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Text(
                    l10n.chooseLanguageHint,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: bp == AppBreakpoint.mobile ? 14 : 15,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final selectedCode = controller.selectedCode.value;
                if (crossAxisCount == 1) {
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: AppLocales.all.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) => _LanguageTile(
                      option: AppLocales.all[index],
                      selected: selectedCode == AppLocales.all[index].storageCode,
                      onTap: () => controller.select(
                        AppLocales.all[index].storageCode,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.fromLTRB(
                    bp == AppBreakpoint.desktop ? 28 : 20,
                    8,
                    bp == AppBreakpoint.desktop ? 28 : 20,
                    16,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: bp == AppBreakpoint.desktop ? 3.2 : 2.8,
                  ),
                  itemCount: AppLocales.all.length,
                  itemBuilder: (context, index) {
                    final option = AppLocales.all[index];
                    return _LanguageTile(
                      option: option,
                      selected: selectedCode == option.storageCode,
                      onTap: () => controller.select(option.storageCode),
                    );
                  },
                );
              }),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  bp == AppBreakpoint.mobile ? 16 : 28,
                  0,
                  bp == AppBreakpoint.mobile ? 16 : 28,
                  16,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          bp == AppBreakpoint.mobile ? double.infinity : 360,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isSubmitting.value
                              ? null
                              : controller.confirm,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final AppLocaleOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.accent : AppColors.border,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      option.nativeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      option.englishName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? AppColors.accent : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
