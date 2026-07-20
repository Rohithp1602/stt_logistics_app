import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/fab_tutorial_overlay.dart';
import '../../../widgets/trendy_bottom_nav.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../settings/views/settings_view.dart';
import '../../shipment/views/shipment_list_view.dart';
import '../controllers/main_shell_controller.dart';

/// Main application shell with bottom navigation.
class MainShellView extends StatefulWidget {
  const MainShellView({super.key});

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FabTutorialOverlay.showIfNeeded(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainShellController>();
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomeView(),
            ShipmentListView(),
            ProfileView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => TrendyBottomNav(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTab,
          onAdd: controller.openCreateShipment,
          homeLabel: l10n.home,
          shipmentsLabel: l10n.shipments,
          profileLabel: l10n.profile,
          settingsLabel: l10n.settings,
        ),
      ),
    );
  }
}
