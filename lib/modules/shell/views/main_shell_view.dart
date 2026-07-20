import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/fab_tutorial_overlay.dart';
import '../../../widgets/responsive_page.dart';
import '../../../widgets/trendy_bottom_nav.dart';
import '../controllers/main_shell_controller.dart';

/// Main application shell with adaptive sidebar / bottom navigation.
class MainShellView extends StatefulWidget {
  const MainShellView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!ResponsivePage.isWide(context)) {
        FabTutorialOverlay.showIfNeeded(context);
      }
    });
  }

  void _onTab(int index) {
    Get.find<MainShellController>().changeTab(index);
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _onAdd() {
    Get.find<MainShellController>().openCreateShipment();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final wide = ResponsivePage.isWide(context);
    final index = widget.navigationShell.currentIndex;

    // Keep GetX tab index in sync with the URL branch.
    final shell = Get.find<MainShellController>();
    if (shell.tabIndex.value != index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && shell.tabIndex.value != index) {
          shell.tabIndex.value = index;
        }
      });
    }

    if (wide) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          children: [
            AppSideNav(
              currentIndex: index,
              onTap: _onTab,
              onAdd: _onAdd,
              homeLabel: l10n.home,
              shipmentsLabel: l10n.shipments,
              profileLabel: l10n.profile,
              settingsLabel: l10n.settings,
              newShipmentLabel: l10n.addShipment,
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: ResponsivePage(
                child: widget.navigationShell,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: widget.navigationShell,
      bottomNavigationBar: TrendyBottomNav(
        currentIndex: index,
        onTap: _onTab,
        onAdd: _onAdd,
        homeLabel: l10n.home,
        shipmentsLabel: l10n.shipments,
        profileLabel: l10n.profile,
        settingsLabel: l10n.settings,
      ),
    );
  }
}
